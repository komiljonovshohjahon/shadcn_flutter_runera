I’d do it in this order, because it keeps the changes controlled and easy to review.

**Step 1**
Define the actual Runera color tokens in [generated_themes.dart](/Users/shoh/Documents/github/shadcn_flutter_runera/lib/src/theme/generated_themes.dart#L34).

- Replace `lightRunera = lightNeutral` and `darkRunera = darkNeutral`.
- Start with light mode only if you want the safest path.
- Use the PDF values directly for:
  - `primary`: `#0E043E`
  - `accent`: `#3B6EF5`
  - `background/card/popover`: `#FFFFFF`
  - `foreground`: `#0F172A`
  - `secondary/muted`: `#F5F7FB`
  - `border/input`: `#E5E7EB`
  - `ring`: `#3B6EF5`

Goal: make `ColorSchemes.runera(...)` visibly distinct before touching anything else.

**Step 2**
Add a real Runera theme preset in [theme.dart](/Users/shoh/Documents/github/shadcn_flutter_runera/lib/src/theme/theme.dart#L178), not just a color scheme.

- Keep `ThemeData` generic.
- Add a helper/factory like `ThemeData.runeraLight()` and later `ThemeData.runeraDark()`.
- Set:
  - `colorScheme: ColorSchemes.lightRunera`
  - `radius: 1.0` so cards/buttons land around the `12-16px` range from the PDF
  - `density`: slightly roomier than default
  - `surfaceOpacity`: probably `null` or very close to `1`
  - `surfaceBlur`: low or `null`

Goal: encode the brand at the theme level, not only in colors.

**Step 3**
Create Runera typography in [typography.dart](/Users/shoh/Documents/github/shadcn_flutter_runera/lib/src/theme/typography.dart#L116).

- Add `Typography.runera()`.
- If Inter is available, use it for `sans`.
- If not, keep Geist for now and tune the weights/sizes to match the brand tone.
- Make headings slightly stronger and cleaner:
  - `h1`: bold
  - `h2/h3/h4`: semibold to bold
  - body: regular/medium
  - muted text: keep readable, not washed out

Goal: make the product feel “premium SaaS” instead of generic shadcn neutral.

**Step 4**
Tune spacing and corner style in [density.dart](/Users/shoh/Documents/github/shadcn_flutter_runera/lib/src/theme/density.dart#L112) and the Runera theme preset in [theme.dart](/Users/shoh/Documents/github/shadcn_flutter_runera/lib/src/theme/theme.dart#L189).

- I would not use fully `spaciousDensity`; it may get too loose for product UI.
- I’d create a Runera-specific density around:
  - container padding: `20`
  - gap: `10`
  - content padding: `16`
- Keep controls clean and roomy, but not marketing-page roomy.

Goal: match the PDF’s “generous spacing” without harming data density.

**Step 5**
Apply the brand to the most visible components first.

- Primary button: deep navy fill, strong contrast, rounded corners.
- Focus states: blue ring, clear and crisp.
- Cards: white surface, soft border, subtle elevation.
- Inputs: minimal, light surface, clear blue focus.
- Tabs/selected nav: use blue accent, not purple.

Goal: the theme should feel Runera in real screens, not only in tokens.

**Step 6**
Only after light mode feels correct, design dark mode.

- The PDF is mainly light-mode oriented.
- Dark mode should be inferred carefully from the logo assets, not just auto-inverted.
- I’d use:
  - deep navy background
  - pale blue-white foreground
  - blue accent for interaction
  - the purple from the logo as a secondary/supporting brand color, not the main accent

Goal: avoid a dark theme that is technically branded but visually off.

**Step 7**
Add one small demo/snapshot screen to validate the theme.

- Buttons
- Inputs
- Cards
- Tabs
- Dialog/popover
- A small chart sample

Goal: catch problems with contrast, spacing, and radius before the brand spreads through the library.

My recommendation is to start with only Steps 1 and 2 first. That gives you the biggest visual shift with the smallest code footprint.

**Current Status**
Applied so far:
- Step 1: Runera color tokens
- Step 2: Runera theme presets
- Step 3: Runera typography
- Step 4: Runera density and radius
- Step 5 partial: buttons, text fields, cards/surfaces, select/date/time-related form controls, switch, and radio card

Not applied yet and intentionally deferred for now:
- Checkbox
- Multiple choice
- Autocomplete
- Item picker
- Object input
- Slider
- Tabs/navigation
- Additional dialog/popover-specific polish
- Dedicated demo/showcase screen
