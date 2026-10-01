# Garage flow

First launch opens two setup steps. Returning launches restore the saved garage.

## Startup routing

`CarLogApp` uses `GetMaterialApp` with `RootBinding`. The binding directly creates and registers the app-scoped `MainAppController` permanently in GetX; controllers are not registered in Injectable/GetIt. Its `onReady()` calls `getVehicles()` through `GetGarageUseCase`, reading the ObjectBox-backed garage repository once. Navigation waits until the Navigator is mounted because localization delegates can delay its first frame:

- A cached vehicle is assigned to the shared `VehicleController`; startup is replaced by `/main`, containing the main shell and navigation bar.
- An empty cache replaces startup with `/onboarding`, displaying `VehicleOnboardingPage` independently of the main shell. No bottom navigation is shown.
- Read failure keeps `StartupPage` visible with Retry; it does not treat corrupt/unavailable cache as an empty garage.
- Onboarding persists the first vehicle before calling `MainAppController.completeOnboarding()`. This assigns the saved vehicle and replaces onboarding with `/main`, without a second cache read.

`Get.offAllNamed` clears startup/onboarding from the back stack. RootBinding creates `MainAppController()` only if absent. GetX owns its lifecycle; its `onClose()` closes the active vehicle controller. Onboarding and modal widgets directly create their form controllers and call `onStart()`/`onDelete()` for their lifecycle. `VehiclePage` only renders the loaded garage; it no longer performs startup loading or embeds onboarding.

1. Enter a 17-character VIN or choose manual entry. NHTSA vPIC fills available make, model, year, body, fuel and engine details. Green checks mark decoded fields; every value stays editable. Missing values, empty results and network failures support manual entry. Fields expand with `AnimatedSize`.
2. Enter current kilometres and a configurable oil interval. Optionally add the last oil/filter service, dated repairs or maintenance, their kilometre readings and costs, and insurance expiry. Unknown oil history remains unknown on the dashboard.

Each onboarding form keeps one mounted `SmartForm` per controller. Step visibility preserves state while `AnimatedSize` animates the visible height; forms are never duplicated in an `AnimatedSwitcher`. Status messages occupy a fixed layout slot so VIN results/errors do not remount attached forms. Back clears field focus before hiding the service step; scrolling dismisses the keyboard.

Garage shows the car, oil service progress, remaining/overdue kilometres, insurance expiry and maintenance costs for the current year. Actions add service/fuel records and update the odometer. Timeline groups records by year/month and filters categories. Export PDF shares complete history, using a bundled Unicode font offline. Analytics totals recorded costs by category.

## Package integration

| pinz.dev package | Role |
| --- | --- |
| `smart_form_fields` | Form controllers, validation and first-error navigation |
| `selection_sheet` | Typed multi-selection for replaced filters |
| `flutter_liquid_glass_kit` | Garage / Timeline / Analytics / Settings navigation |
| `sensor_shadows` | Shared tilt lighting for cards, buttons, action tiles, history filters and navigation; reduced-motion support |
| `flutter_mesh_gradients` | Static dark amber backdrop without continuous animation |
| `smart_domain` | Validated VIN use case and explicit success/failure results |
| `smart_repository` | VIN-keyed cache and request coordination |
| `assets_generator_kit` | Generated typed font asset accessor |

The existing domain/data/DI structure created with `clean_architect` is retained. Audio, transfers, authentication refresh, watch connectivity, live activities and server-defined pages have no required role in this flow. Garage does not create unsigned/example wallet passes.

## Architecture

- `domain/lib/features/garage/entities/`: Freezed `GarageVehicle` and `ServiceRecord`, generated JSON serialization and immutable `copyWith`.
- `domain/lib/features/garage/repositories/garage_repository.dart`: repository contract.
- `domain/lib/features/garage/usecases/`: `GetGarageUseCase` and `SaveGarageUseCase` isolate repository reads/writes from presentation.
- `domain/lib/features/vehicle/usecases/decode_vin_use_case.dart`: validated VIN use case.
- `data/lib/features/vehicle/remote/`: NHTSA request and response mapping.
- `data/lib/features/vehicle/local/`: ObjectBox storage, mutable database schemas and legacy JSON import.
- `data/lib/features/vehicle/mappers/`: conversion between database schemas and Freezed domain entities.
- `data/lib/features/vehicle/repositories/`: injected repository implementation coordinating local and remote sources.
- `presentation/lib/bindings/root_binding.dart`: registers the app-scoped controller in GetX.
- `presentation/lib/controllers/`: directly created main-app, setup, vehicle, service-record and odometer controllers; startup routing, validation, persistence, calculations and interaction actions.
- `presentation/lib/controllers/base/base_controller.dart`: Intact-style lifecycle hooks, `getInstance<T>()`, reactive pending IDs and use-case helpers with `try/finally` cleanup.
- `presentation/assets/localization/` and `presentation/lib/localization/`: English/Romanian translations, asset loader and generated `LocaleKeys`.
- `presentation/lib/navigation/app_routes.dart`: startup, main and onboarding route names.
- `presentation/lib/pages/startup/`: loading/cache-error screen.
- `presentation/lib/pages/vehicle/`: garage page and two-step onboarding page.
- `presentation/lib/pages/vehicle/widgets/`: vehicle-only dashboard, action tiles, setup steps and odometer dialog.
- `presentation/lib/pages/timeline/`: photo-inspired service history, category filters, dated rail and record cards.
- `presentation/lib/pages/analytics/` and `presentation/lib/pages/settings/`: separate pages for existing cost totals and vehicle details.
- `presentation/lib/widgets/`: cross-page cards, backdrop, sensor surfaces/buttons, badges and service-record editor.

Photos contain two unique screens: garage and service history. The hand-painted car is removed from setup and garage. No replacement artwork is shown yet; body-type images can be added to `VehicleDashboard` later. Vehicle body data remains available in the domain entity.

Cards use the sensor gradient directly so tilt lighting remains visible. Buttons use `SensorShadowButton`; cards, action tiles, filters and navigation share the existing app-level `SensorShadows` scope. Reduced-motion settings suppress tilt; missing sensor hardware retains neutral lighting and working controls.

Injectable generates registrations for data and domain only. Startup initializes data (including ObjectBox), then domain. All controllers, including AuthController, extend `BaseController`; no controller or binding has an Injectable annotation. Controllers resolve domain use cases through `getInstance<T>()`, never `GarageRepository` directly. Mutable UI state uses `Rx`, `Rxn`, `RxList` or `RxMap`; `Obx` observes it without `update()` calls. Immutable dependencies and Flutter form/text controller handles stay native. Loading is derived from pending operation IDs, not stored booleans. `onClose()` cleans up resources. Repositories and data sources remain lazy singletons. Freezed applies to domain value objects, not mutable ObjectBox schemas or controllers. This follows the ownership/reactive patterns in `intact-mobile-app` and [autodiag_flutter](https://github.com/PinzaruDaniel/autodiag_flutter).

## Localization

EasyLocalization wraps the app before startup. English remains the fallback; Romanian is supported and language can be changed in Settings. Every app-owned visible string, tooltip, validation/error message, category and PDF label uses generated `LocaleKeys`. `LocalizedObx` subscribes to both Rx and locale-delegate changes; the app synchronizes EasyLocalization's locale with `Get.locale`. Dates/months and numbers use locale-aware Intl formatting. Technical IDs, asset paths and user/API-entered vehicle values are not translated. Generated oil/filter records store stable keys and translate at rendering/export time; user-written titles and notes remain unchanged. VIN domain failures return message keys, keeping localization out of domain/data.

## Persistence and limits

`GarageLocalDataSource` stores one vehicle and its related service records in ObjectBox under the application-documents `objectbox` directory. Saves replace the vehicle and its history transactionally, removing superseded records. Existing ObjectBox schema identifiers are preserved. A legacy `garage.json` imports when no ObjectBox garage exists; the original file is retained. Subsequent loads use ObjectBox. Save failure does not update the displayed vehicle. Load failure offers retry instead of resetting setup over existing data. No cloud synchronization or multiple-car management is included.

vPIC is a public VIN decoder, not a repair-history provider. Coverage varies, especially for vehicles outside the US market. Owner-entered service history is not verified. The initial 10,000 km oil interval is editable during setup and must be adjusted to the vehicle's actual maintenance schedule. Costs are currently recorded in MDL, mileage in kilometres. Vehicle artwork is intentionally absent until body-type assets are supplied.

## Verification

Regenerate code from the repository root, in dependency order:

```sh
(cd domain && dart run build_runner build)
(cd data && dart run build_runner build)
```

From `presentation`:

```sh
flutter pub get
dart run assets_generator_kit generate
dart run easy_localization:generate -S assets/localization -s en.json -O lib/localization/generated_keys -o locale_keys.g.dart -f keys
flutter test
flutter analyze
flutter build ios --simulator --debug
```

Host-side persistence tests require the matching ObjectBox native library. On macOS, download the [ObjectBox 5.3.2 macOS release](https://github.com/objectbox/objectbox-c/releases/download/v5.3.2/objectbox-macos-universal.zip) and place its `lib/libobjectbox.dylib` in `presentation/lib/`. Host libraries are gitignored and not bundled as Flutter assets. Device/simulator apps use `objectbox_flutter_libs` instead.

Workflow tests cover domain DI, controller ownership, pending-operation cleanup, direct reactive updates, runtime locale switching and translation completeness, manual onboarding, partial VIN results, invalid/offline VIN handling, ObjectBox persistence and record cleanup, one-time legacy import, oil calculations, backward odometer rejection, timeline category filtering and offline Unicode PDF generation. Optional screenshot capture:

```sh
flutter test --dart-define=CAPTURE_PREVIEWS=true
```

Images are written to `/private/tmp/car-log-preview`. Native share sheets and actual device sensor sampling require device testing. Regression tests verify category navigation, controller grouping, narrow-screen history, disabled buttons, synthetic tilt response and reduced-motion behavior.

Font: Noto Sans, SIL Open Font License; bundled license in `assets/fonts/LICENSE`.
