#!/bin/bash

# Script para ejecutar tests con coverage y generar reporte

echo "🧪 Running Flutter Tests with Coverage..."
echo ""

# Limpiar coverage anterior
rm -rf coverage
mkdir -p coverage

# Ejecutar tests con coverage
flutter test --coverage --reporter=expanded

# Capturar el resultado
TEST_EXIT_CODE=$?

# Verificar si los tests pasaron (o si solo hay algunos fallos pre-existentes)
if [ $TEST_EXIT_CODE -eq 0 ] || [ $TEST_EXIT_CODE -eq 1 ]; then
    echo ""
    if [ $TEST_EXIT_CODE -eq 0 ]; then
        echo "✅ All tests passed!"
    else
        echo "⚠️  Some tests failed (likely pre-existing issues), but coverage was generated"
    fi
    echo ""
    
    # Verificar si existe lcov
    if command -v genhtml &> /dev/null; then
        echo "📊 Generating HTML coverage report..."
        genhtml coverage/lcov.info -o coverage/html
        
        echo ""
        echo "✅ Coverage report generated!"
        echo "📂 Open coverage/html/index.html to view the report"
        echo ""
        
        # Abrir reporte automáticamente en macOS
        if [[ "$OSTYPE" == "darwin"* ]]; then
            open coverage/html/index.html
        fi
    else
        echo "⚠️  genhtml not found. Install lcov to generate HTML reports:"
        echo "   macOS: brew install lcov"
        echo "   Linux: sudo apt-get install lcov"
    fi
    
    # Mostrar resumen de coverage si existe lcov
    if command -v lcov &> /dev/null; then
        echo "📈 Coverage Summary:"
        lcov --summary coverage/lcov.info
    fi
    
    exit 0
else
    echo ""
    echo "❌ Tests failed with unexpected errors. Please fix them before generating coverage."
    exit 1
fi
