# Test Coverage Report

Este documento describe cómo ejecutar tests con coverage para el proyecto.

## Prerequisitos

Asegúrate de tener instalado:
- Flutter SDK (>=3.10.1)
- Dart SDK

## Ejecutar Todos los Tests

Para ejecutar todos los tests del proyecto:

```bash
flutter test
```

## Ejecutar Tests con Coverage

Para generar un reporte de coverage:

```bash
flutter test --coverage
```

Este comando generará un archivo `coverage/lcov.info` con la información de coverage.

## Ver Reporte de Coverage

### Opción 1: Usar genhtml (Linux/macOS)

```bash
# Instalar lcov si no lo tienes
# macOS: brew install lcov
# Linux: sudo apt-get install lcov

# Generar reporte HTML
genhtml coverage/lcov.info -o coverage/html

# Abrir reporte en navegador
open coverage/html/index.html  # macOS
xdg-open coverage/html/index.html  # Linux
```

### Opción 2: Usar VS Code Extension

Instala la extensión "Coverage Gutters" para VS Code para ver el coverage directamente en el editor.

## Ejecutar Tests Específicos

### Tests de Foundations

```bash
flutter test test/design/utils/foundations/
```

### Tests de Responsive System

```bash
flutter test test/design/responsive/
```

### Tests de Formatters

```bash
flutter test test/design/utils/formats/
```

### Tests de Componentes Atómicos

```bash
flutter test test/design/atomic/
```

## Coverage Goal

El objetivo es mantener al menos **80% de coverage** en toda la capa de diseño.

## CI/CD Integration

Para integrar con CI/CD, agrega el siguiente comando en tu pipeline:

```yaml
# GitHub Actions example
- name: Run tests with coverage
  run: flutter test --coverage
  
- name: Upload coverage to Codecov
  uses: codecov/codecov-action@v3
  with:
    files: ./coverage/lcov.info
```

## Archivos Excluidos

Los siguientes archivos están excluidos del reporte de coverage:

- `*.g.dart` - Archivos generados
- `*.gen.dart` - Archivos generados por FlutterGen
- `*_test.dart` - Archivos de test

## Comandos Útiles

```bash
# Ejecutar tests en modo watch
flutter test --watch

# Ejecutar tests con reporter verbose
flutter test --reporter expanded

# Ejecutar tests específicos por nombre
flutter test --name "ColorFoundation"

# Ejecutar tests excluyendo tags
flutter test --exclude-tags=integration
```

## Troubleshooting

### Coverage no se genera

Asegúrate de que el archivo `test/` existe y tiene tests válidos.

### Tests fallan

1. Ejecuta `flutter pub get` para asegurar que todas las dependencias están instaladas
2. Verifica que estás usando la versión correcta de Flutter
3. Limpia el cache: `flutter clean && flutter pub get`

## Referencias

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Dart Test Package](https://pub.dev/packages/test)
- [Coverage Package](https://pub.dev/packages/coverage)
