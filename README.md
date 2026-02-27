# Stoyco Partners Shared Design System

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=flat&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/license-Proprietary-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-3.0.3-brightgreen.svg)](CHANGELOG.md)

> A comprehensive, production-ready Flutter design system built on Atomic Design principles, providing a scalable foundation for consistent user experiences across the Stoyco Partners ecosystem.

## 📋 Table of Contents

- [Overview](#overview)
- [Design Philosophy](#design-philosophy)
- [Architecture](#architecture)
- [Design Tokens](#design-tokens)
- [Color System](#color-system)
- [Typography](#typography)
- [Responsive System](#responsive-system)
- [Component Library](#component-library)
- [Getting Started](#getting-started)
- [Usage Examples](#usage-examples)
- [Testing](#testing)
- [Contributing](#contributing)

## Overview

**Stoyco Partners Shared** is an enterprise-grade design system that implements Atomic Design methodology, providing a comprehensive suite of reusable components, design tokens, and utilities. Built with Flutter and Dart, it ensures visual consistency, accessibility, and maintainability across all Stoyco Partners applications.

### Key Features

- 🎨 **Complete Design System** - Comprehensive color palettes, typography scales, and spacing systems
- 🧩 **Atomic Design Architecture** - Modular components following atoms → molecules → organisms pattern
- 📱 **Responsive by Default** - Adaptive layouts that work seamlessly across all screen sizes
- 🎯 **Type-Safe Tokens** - Auto-generated design tokens from source files
- ♿ **Accessibility First** - WCAG compliant color contrast and semantic markup
- 📊 **Advanced Charting** - Custom chart implementations with interactive tooltips
- 🔧 **Extensive Utilities** - Formatters, validators, and helper functions
- 🧪 **Fully Tested** - Comprehensive test coverage for reliability

## Design Philosophy

### Atomic Design Methodology

Our design system follows Brad Frost's Atomic Design principles, organizing components into five distinct levels:

```
Atoms (Basic building blocks)
  ↓
Molecules (Simple combinations)
  ↓
Organisms (Complex UI sections)
  ↓
Templates (Page-level layouts)
  ↓
Pages (Specific instances)
```

#### Component Hierarchy

**Atoms** - Foundational elements that can't be broken down further
- Buttons, chips, form fields, icons, images
- Individual text styles, color swatches
- Basic inputs and switches

**Molecules** - Simple component groups with specific functionality
- Chart legends, tooltips, selectors
- Phone validators, menu chips
- Content stat displays

**Organisms** - Complex components that form distinct sections
- Complete charts (linear, bar, pie)
- Content cards, modals
- Loading screens, navigation components

### Design Principles

1. **Consistency** - Unified visual language across all touchpoints
2. **Scalability** - Components designed to grow with product needs
3. **Accessibility** - Inclusive design for all users
4. **Performance** - Optimized components with minimal overhead
5. **Developer Experience** - Intuitive APIs and comprehensive documentation

## Architecture

### Project Structure

```
lib/design/
├── atomic/                    # Component library
│   ├── atoms/                 # Basic components
│   │   ├── buttons/
│   │   ├── cards/
│   │   ├── chips/
│   │   ├── formfields/
│   │   └── items/
│   ├── molecules/             # Composite components
│   │   ├── chart_legend/
│   │   ├── tooltip/
│   │   └── selectors/
│   └── organisms/             # Complex sections
│       ├── graphics/          # Chart implementations
│       ├── content_card/
│       └── modals/
├── models/                    # Data models
├── responsive/                # Responsive system
│   ├── formats/
│   ├── screen_size/
│   └── breakpoint.dart
├── types/                     # Type definitions
├── utils/                     # Utilities
│   ├── formats/               # Formatters (dates, numbers)
│   ├── foundations/           # Design foundations
│   │   ├── color_foundation.dart
│   │   └── font_foundation.dart
│   ├── logs/                  # Logging utilities
│   ├── tokens/                # Design tokens
│   │   └── gen/               # Auto-generated tokens
│   └── validators/            # Input validators
└── accesibility/              # Accessibility features
```

## Design Tokens

Design tokens are the atomic values that define the visual design system. We use **FlutterGen** to automatically generate type-safe tokens from source files.

### Token Generation

Tokens are automatically generated from:
- `lib/assets/colors/colors.xml` → Color tokens
- Font files → Font family tokens
- Asset files → Asset tokens

```dart
// Auto-generated tokens
import 'package:stoyco_partners_shared/design/utils/tokens/gen/colors.gen.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/fonts.gen.dart';
import 'package:stoyco_partners_shared/design/utils/tokens/gen/assets.gen.dart';

// Usage
final color = StoycoColorsToken.primary;
final font = StoycoFontFamilyToken.gilroy;
final icon = StoycoAssetsToken.lib.assets.icons.arrowUp;
```

### Foundation Classes

**ColorFoundation** - Semantic color access
```dart
ColorFoundation.text.black        // Text colors
ColorFoundation.background.white  // Background colors
ColorFoundation.border.grey      // Border colors
ColorFoundation.gradient.primary // Gradient definitions
ColorFoundation.shadow.default   // Shadow colors
```

**FontFoundation** - Typography styles
```dart
FontFoundation.heading.bold24Black      // Headings
FontFoundation.body.regular16White      // Body text
FontFoundation.paragraph.medium14Grey5  // Paragraphs
```

## Color System

### Color Architecture

Our color system is organized into semantic categories for different use cases:

#### SA (Stoyco Artists) Palette
Primary brand colors for the Stoyco Artists ecosystem
```dart
ColorFoundation.text.saHighlights  // #9E80E1 - Primary purple
ColorFoundation.text.saLight       // #F2E9F2 - Light purple
ColorFoundation.text.saDark        // #14121D - Dark purple
ColorFoundation.text.saDisabled    // #C8B5E9 - Disabled states
ColorFoundation.text.saError       // #E87D99 - Error states
ColorFoundation.text.saSuccess     // #819384 - Success states
```

#### Complementary Colors
Supporting colors for accents and highlights
```dart
ColorFoundation.text.complementary3  // #FEA92A - Orange accent
ColorFoundation.text.complementary4  // #15B790 - Green accent
```

#### Tertiary Colors
Additional accent colors
```dart
ColorFoundation.text.tertiary1  // #F25444 - Error red
ColorFoundation.text.tertiary3  // #F27B2C - Warning orange
```

#### Grey Scale
Neutral colors for text, backgrounds, and borders
```dart
ColorFoundation.text.grey1  // #575757 - Darkest
ColorFoundation.text.grey2  // #797979
ColorFoundation.text.grey3  // #A0A0A0
ColorFoundation.text.grey4  // #C2C2C2
ColorFoundation.text.grey5  // #E7E7E7 - Lightest
ColorFoundation.text.grey7  // #545F71 - Slate grey
```

#### Blue Palette
Information and interactive element colors
```dart
ColorFoundation.text.blue5   // #E6F4F9 - Lightest
ColorFoundation.text.blue10  // #CDE8F2 - Light
ColorFoundation.text.blue30  // #B4DDEC - Medium
ColorFoundation.text.blue11  // #006DB3 - Primary blue
```

#### Chart Colors
Specialized colors for data visualization
```dart
ColorFoundation.background.chartBlack  // #43414A - Chart backgrounds
ColorFoundation.background.blueChart   // #3C80FF - Primary chart data
ColorFoundation.background.greenChart  // Custom chart colors
```

### Color Usage Guidelines

**Text Colors**
- Primary text: `black`, `saDark`
- Secondary text: `grey1`, `grey2`, `grey3`
- Disabled text: `saDisabled`, `saTextDisabled`
- Interactive text: `saHighlights`, `blue11`

**Background Colors**
- Primary backgrounds: `white`, `saLight`
- Card backgrounds: `cardAffirmative1`, `cardIntermediate1`
- Overlays: `blur`, `blackTransparent`

**Border Colors**
- Subtle borders: `grey4`, `grey5`
- Interactive borders: `saHighlights`, `blue11`
- Error borders: `saError`, `tertiary1`

## Typography

### Font Families

We use three carefully selected font families, each serving specific purposes:

#### Gilroy (Primary Font)
Modern geometric sans-serif for headings and UI elements
- **Weights**: Light (300), Regular (400), Medium (500), Semibold (600), Bold (700), Extrabold (800)
- **Use cases**: Headings, buttons, navigation, body text

```dart
FontFamily: StoycoFontFamilyToken.gilroy
```

#### Akkurat (Display Font)
Precise neo-grotesque for special elements
- **Weights**: Light (300), Regular (400), Medium (500), Semibold (600), Bold (700)
- **Use cases**: Feature headings, emphasized content

```dart
FontFamily: StoycoFontFamilyToken.akkurat
```

#### Apercu (Monospace)
Monospaced font for data and numerical content
- **Weights**: Regular (400), Medium (500), Bold (700)
- **Use cases**: Charts, statistics, code, numerical displays

```dart
FontFamily: StoycoFontFamilyToken.apercu
```

### Type Scale

Our typography system uses a modular scale with predefined sizes:

| Size | Usage | Line Height |
|------|-------|-------------|
| 24px | H1 Headings | 32px |
| 22px | H2 Headings | 30px |
| 20px | H3 Headings | 28px |
| 19px | H4 Headings | 26px |
| 18px | Large Body | 24px |
| 16px | Body Text | 22px |
| 14px | Small Body | 20px |
| 12px | Captions | 18px |
| 10px | Micro Text | 14px |

### Text Style System

Pre-configured text styles combining font, size, weight, and color:

```dart
// Heading styles
FontFoundation.heading.bold24Black
FontFoundation.heading.semiBold22White
FontFoundation.heading.medium20Grey1

// Body styles
FontFoundation.body.bold18White
FontFoundation.body.regular16Black
FontFoundation.body.medium14Grey3

// Paragraph styles
FontFoundation.paragraph.bold14White
FontFoundation.paragraph.regular12Grey5
```

### Typography Best Practices

1. **Hierarchy**: Use size and weight to establish clear content hierarchy
2. **Readability**: Maintain minimum 16px for body text on mobile
3. **Contrast**: Ensure WCAG AA compliance (4.5:1 for normal text)
4. **Line Length**: Keep line length between 50-75 characters
5. **Letter Spacing**: Use negative spacing (-0.2px) for large headings

## Responsive System

### Screen Size Management

Our responsive system adapts to different screen sizes using a flexible calculation engine:

```dart
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';

// Responsive sizing
StoycoScreenSize.width(context, 100)   // Proportional width
StoycoScreenSize.height(context, 50)   // Proportional height
StoycoScreenSize.fontSize(context, 16) // Responsive font size
StoycoScreenSize.screenWidth(context)  // Full screen width
StoycoScreenSize.screenHeight(context) // Full screen height
```

### Breakpoint System

```dart
import 'package:stoyco_partners_shared/design/responsive/breakpoint.dart';

// Define breakpoints
final breakpoint = Breakpoint(
  mobile: 0,
  tablet: 768,
  desktop: 1024,
  wide: 1440,
);

// Responsive values
final padding = breakpoint.resolve(
  mobile: 16.0,
  tablet: 24.0,
  desktop: 32.0,
);
```

### Adaptive Builder

```dart
import 'package:stoyco_partners_shared/design/responsive/adaptive_builder.dart';

AdaptiveBuilder(
  mobile: (context) => MobileLayout(),
  tablet: (context) => TabletLayout(),
  desktop: (context) => DesktopLayout(),
)
```

### Spacing System

**Gutter** - Consistent spacing between elements
```dart
Gutter(16)  // Single spacing
Gutter.vertical(24)  // Vertical only
Gutter.horizontal(32)  // Horizontal only

// Auto-generated spacing
Gutter.separateChildren(
  children: [...],
  extent: 16.0,
)
```

**Margin** - External spacing
```dart
Margin.all(16)
Margin.symmetric(vertical: 24, horizontal: 16)
```

## Component Library

### Atoms

#### Buttons
```dart
// Primary button
ButtonPrimary(
  text: 'Submit',
  onPressed: () {},
)

// Secondary button
ButtonSecondary(
  text: 'Cancel',
  onPressed: () {},
)
```

#### Chips
```dart
// Monotone chip with glassmorphic effect
ChipMonotoneNoise(
  child: Text('Featured'),
)

// Content chip
ContentChip(
  message: 'Category',
  tooltipMessage: 'Content category',
)
```

#### Form Fields
```dart
// Custom text field
CustomFormfield(
  controller: controller,
  hintText: 'Enter text',
  validator: FormfieldValidatorType.email,
)

// Dropdown field
CustomDropdownfield(
  items: ['Option 1', 'Option 2'],
  onChanged: (value) {},
)
```

### Molecules

#### Chart Legend
```dart
ChartLegend(
  items: [
    ChartLegendItemModel(
      color: Colors.blue,
      label: 'Series 1',
      value: '45%',
    ),
  ],
)
```

#### Tooltips
```dart
// Custom tooltip
CustomTooltip(
  message: 'Helpful information',
  position: TooltipPosition.top,
  child: Icon(Icons.info),
)

// Bubble tooltip for charts
BubbleTooltip(
  value: '125k',
  lineStartOffset: Offset(100, 150),
  lineEndOffset: Offset(200, 100),
)
```

#### Phone Validator
```dart
PhoneValidatorInput(
  controller: phoneController,
  onValidationChanged: (isValid) {},
)
```

### Organisms

#### Linear Chart
```dart
LinearChart(
  data: LinearChartData(
    rangeX: ['Jan', 'Feb', 'Mar'],
    rangeY: [0, 100, 200],
    pointsFan: [...],
    pointsMember: [...],
  ),
  lineConfigs: [
    LinearChartLineConfig(
      key: 'fan',
      displayLabel: 'Fans',
      color: Colors.blue,
    ),
  ],
  height: 300,
)
```

#### Bar Chart
```dart
BarHorizontalChart(
  data: BarHorizontalChartData(
    bars: [...],
    maxValue: 1000,
  ),
)
```

#### Pie Chart
```dart
PieChart(
  sections: [
    PieChartSectionData(
      value: 40,
      title: 'Category A',
      color: Colors.blue,
    ),
  ],
)
```

#### Content Cards
```dart
// Music content card
MusicContent(
  data: MusicContentModel(
    title: 'Album Name',
    artist: 'Artist Name',
    plays: 1000000,
  ),
)

// Experience content card
ExperiencesContent(
  data: ExperiencesContentModel(
    eventName: 'Concert',
    date: DateTime.now(),
    ticketsSold: 500,
  ),
)
```

## Getting Started

### Installation

Add this package to your project's `pubspec.yaml`:

```yaml
dependencies:
  stoyco_partners_shared:
    path: ../stoyco_partners_shared  # Local path
    # Or from a git repository:
    # git:
    #   url: https://github.com/your-org/stoyco_partners_shared.git
    #   ref: main
```

### Import

```dart
import 'package:stoyco_partners_shared/stoyco_partners_shared.dart';
```

### Basic Setup

1. **Initialize Design System**

```dart
import 'package:flutter/material.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: ColorFoundation.background.saHighlights,
        fontFamily: StoycoFontFamilyToken.gilroy,
      ),
      home: MyHomePage(),
    );
  }
}
```

2. **Use Components**

```dart
import 'package:stoyco_partners_shared/design/atomic/atoms/buttons/button_primary.dart';

ButtonPrimary(
  text: 'Get Started',
  onPressed: () {
    // Handle action
  },
)
```

## Usage Examples

### Creating a Responsive Card

```dart
import 'package:stoyco_partners_shared/design/responsive/screen_size/stoyco_screen_size.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/font_foundation.dart';

Container(
  padding: EdgeInsets.all(StoycoScreenSize.width(context, 16)),
  decoration: BoxDecoration(
    color: ColorFoundation.background.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: ColorFoundation.shadow.default,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Card Title',
        style: FontFoundation.heading.bold18Black,
      ),
      SizedBox(height: StoycoScreenSize.height(context, 8)),
      Text(
        'Card description text',
        style: FontFoundation.body.regular14Grey2,
      ),
    ],
  ),
)
```

### Formatting Numbers and Dates

```dart
import 'package:stoyco_partners_shared/design/utils/formats/numbers.dart';
import 'package:stoyco_partners_shared/design/utils/formats/dates.dart';

// Number formatting
final formatted = NumbersFormat.formatWithCommas(1234567.89);  // "1,234,567.89"
final compact = NumbersFormat.formatCompact(1500000);          // "1.5M"
final currency = NumbersFormat.formatCurrency(250000, 'MXN'); // "$250,000 MXN"

// Date formatting
final date = DatesFormats.formatDateDDMMYYYY(DateTime.now()); // "27/02/2026"
```

### Building Custom Charts

```dart
import 'package:stoyco_partners_shared/design/atomic/organisms/graphics/linear_chart/linear_chart.dart';

LinearChart(
  data: LinearChartData(
    rangeX: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
    rangeY: [0, 50, 100, 150, 200],
    pointsFan: [
      LinearChartPoint(total: 120, trend: TrendType.up, date: DateTime(2026, 2, 24)),
      LinearChartPoint(total: 145, trend: TrendType.up, date: DateTime(2026, 2, 25)),
      LinearChartPoint(total: 130, trend: TrendType.down, date: DateTime(2026, 2, 26)),
    ],
  ),
  lineConfigs: [
    LinearChartLineConfig(
      key: 'fan',
      displayLabel: 'Fan Growth',
      color: ColorFoundation.background.blueChart,
      strokeWidth: 2.0,
      dotSize: 4.0,
    ),
  ],
  height: 300,
  animationDuration: Duration(milliseconds: 1500),
)
```

## Testing

This design system includes comprehensive test coverage to ensure reliability and stability.

### Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/design/utils/foundations/color_foundation_test.dart
```

### Test Coverage

- ✅ **Foundation Tests** - Color and font foundation classes
- ✅ **Token Tests** - Generated design tokens
- ✅ **Component Tests** - All atomic components (atoms, molecules, organisms)
- ✅ **Responsive Tests** - Screen size calculations and breakpoints
- ✅ **Utility Tests** - Formatters and validators
- ✅ **Widget Tests** - UI component rendering and interaction

### Writing Tests

Example test structure:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:stoyco_partners_shared/design/utils/foundations/color_foundation.dart';

void main() {
  group('ColorFoundation', () {
    test('text colors should have correct values', () {
      expect(ColorFoundation.text.black.value, 0xFF2F2F2F);
      expect(ColorFoundation.text.white.value, 0xFFFFFFFF);
    });
    
    test('background colors should be accessible', () {
      expect(ColorFoundation.background.saLight, isNotNull);
      expect(ColorFoundation.background.white, isNotNull);
    });
  });
}
```

## Contributing

### Development Workflow

1. **Create Feature Branch**
   ```bash
   git checkout -b feature/new-component
   ```

2. **Make Changes**
   - Follow atomic design principles
   - Write tests for new components
   - Update documentation

3. **Run Tests**
   ```bash
   flutter test
   flutter analyze
   dart format .
   ```

4. **Update Changelog**
   - Document changes in `CHANGELOG.md`
   - Follow semantic versioning

5. **Submit Pull Request**
   - Clear description of changes
   - Link to related issues
   - Ensure CI passes

### Code Standards

- **Naming**: Use clear, descriptive names following Dart conventions
- **Documentation**: Document all public APIs with DartDoc comments
- **Testing**: Maintain >80% test coverage
- **Formatting**: Use `dart format` with 80-character line width
- **Analysis**: Pass all `flutter analyze` checks

### Design Token Updates

When updating design tokens:

1. Edit source files (e.g., `lib/assets/colors/colors.xml`)
2. Run FlutterGen: `flutter pub run build_runner build`
3. Update foundation classes if needed
4. Test all affected components
5. Update documentation

## Architecture Decisions

### Why Atomic Design?

- **Reusability**: Build once, use everywhere
- **Consistency**: Unified components ensure brand consistency
- **Scalability**: Easy to extend with new components
- **Testability**: Isolated components are easier to test
- **Documentation**: Clear hierarchy improves understanding

### Why Design Tokens?

- **Single Source of Truth**: One place to manage design decisions
- **Type Safety**: Compile-time checking prevents errors
- **Theming**: Easy to support multiple themes
- **Automation**: Generate code from design files
- **Consistency**: Guaranteed alignment with design specs

### Why Multiple Font Families?

- **Hierarchy**: Different fonts establish visual hierarchy
- **Purpose**: Each font optimized for its use case
- **Performance**: Load only necessary font weights
- **Branding**: Unique combination reinforces brand identity

## License

Proprietary - © 2026 Stoyco. All rights reserved.

This design system is proprietary software owned by Stoyco. Unauthorized use, copying, modification, or distribution is strictly prohibited.

## Support

For questions, issues, or feature requests:
- Create an issue in the project repository
- Contact the design systems team
- Refer to internal documentation

---

**Built with** ❤️ **by the Stoyco Partners Design Systems Team**

*Last updated: February 27, 2026*
