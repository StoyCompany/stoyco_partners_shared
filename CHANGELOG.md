## 2.0.1

### Features

- Add ContentStatWithTooltip widget for enhanced content statistics display with tooltips

## 2.0.1

### Features

- Allow customizable timer duration in PhoneValidatorInput; initialize remaining seconds based on provided duration

## 2.0.0

### Features

- **LinearChart**:
  - Added new LinearChart component with animated line drawing
  - Implemented interactive tooltips with touch indicators using dashed lines
  - Added support for multiple line series with customizable colors and styles
  - Implemented horizontal scrolling for large datasets
  - Added null data validation with informative messages
  - Implemented dynamic Y-axis scaling based on actual data values
  - Added white dots with colored borders for data points
  - Implemented grid customization with adjustable line weights
  - Added label capitalization for X-axis values
  - Integrated with fl_chart library for smooth animations

- **TopTenLocationsFlags**:
  - Optimized list width calculation for better space utilization
  - Removed horizontal scroll when displaying single category
  - Improved alignment of position numbers and country flags
  - Enhanced spacing and layout for better visual consistency

- **BarHorizontalChart**:
  - Added horizontal padding to chart legend for better spacing

- **Code Quality**:
  - Removed all Spanish comments from codebase
  - Improved code documentation consistency across chart components

## 1.0.8

### Features

- Add CardContentFlex widget and enhance ChipMonotoneNoise with child support; improve BarHorizontalChart and TopTenLocationsFlags for better data handling and visualization
- Refactor TopTenLocationsFlags to remove sorting logic and improve rendering
- Removed the internal sorting of location data in \_TopTenLocationsFlagsState.
- Updated the build method to directly use the widget's data for rendering.
- Enhanced the UI to display a message when no ranking data is available.
- Adjusted item layout for better spacing and alignment.
- Add utility function for formatting integers with commas
- Introduced formatWithCommasInt method in NumbersFormat for better integer formatting.
- Add new SVG asset for Stoyco flag
- Added flag_stoyco.svg to assets and updated asset generation.
- Create utility for date formatting
- Added DatesFormats class with a method to format dates in DD/MM/YYYY format.

## 1.0.7

### Features

- Enhance null validation and flexible design of phone input validator

## 1.0.6

### Features

- Added DTO-s for all content types
- Added card design for all content types to create content lists

## 1.0.5

### Features

- Refactored FormFields to have the correct color palette when disabled

## 1.0.4

### Features

- Added saTextDisabled color to underline in CustomDropdownField and CustomSearchDropdownField when isEnabled is false

## 1.0.3

### Features

- Enhance custom checkbox with label tapping
- Enhance design of country code selector to be consistent
- Fix timer color not changing when error is present

## 1.0.2

### Features

- Adjusted design of fields
- Added alert icon

### Features

- **ContenCard**:
  - Added ContentCard widget to use in the Content Section inside a list

- **ContentCardDescription**:
  - Added ContentCardDescription widget. It is part of the ContentCard structure. Right now, it follows the Video/News type of content.

- **ContentCardSkeleton**:
  - Added an Skeleton layout for the ContentCard Using the 'skeletonizer' package. It is intented to be used in the app alongside the Skeletonizer widget when loading.

## 1.0.1

### Features

- **ContenCard**:
  - Added ContentCard widget to use in the Content Section inside a list

- **ContentCardDescription**:
  - Added ContentCardDescription widget. It is part of the ContentCard structure. Right now, it follows the Video/News type of content.

- **ContentCardSkeleton**:
  - Added an Skeleton layout for the ContentCard Using the 'skeletonizer' package. It is intented to be used in the app alongside the Skeletonizer widget when loading.

## 1.0.0

### Features

- **BarHorizontalChart**:
  - Added validation for `maxValue` to prevent rendering issues with invalid values.
  - Refactored to remove unused properties and improve layout for better performance.
  - Introduced `rangeDate` and `filtersSelector` for enhanced data display.

- **CategoryItemModel**:
  - Updated to require `id` for improved data consistency.

- **SelectorItem**:
  - Added a new class to improve type safety in selectors.
  - Refactored `Selector` component to use `SelectorItem` for better maintainability.

- **ChipMonotoneNoise**:
  - Added padding option for better layout customization.

- **Loading Screens**:
  - Refactored animations to improve type safety and enhance user experience.

- **ColorFoundation**:
  - Added `spGreen` color for alerts and updated related components.

## 0.0.8

- Features

- Add sa-green color
- Enhance CustomModal with icon and improved error handling

## 0.0.7

- Features

- Refactored Custom Search Dropdown Field to have an scrollable list

## 0.0.6

- Features

* Added timer to pinput field
* Refactor fields to match Figma design

## 0.0.5

- Features

* Added colors and images

## 0.0.4

- Features

* Added phone validator input using 'pinput' package
* Refactor various fields to use 'reactive_forms' package

## 0.0.3

- Features

* Added CustomSearchFormfield

## 0.0.2

- Features

* Added custom form fields with auto validation
* Added custom button
* Added custom header

## 0.0.1

- Initial release
