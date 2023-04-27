# Parse lexer to java and compile, optionally execute the lexer

$FLEX_FILE = 'src/lexer.flex'
$JAVA_FILE = 'src/Lexer.java'
$CLASS_PATH = 'bin/'
$JAVA_CLASS = 'Lexer'
$INPUT_FILE = 'input.txt'

$aws = ''

# Excute on PowerShell
jflex -nobak -q $FLEX_FILE
javac -d bin $JAVA_FILE

do {
    Write-Host "Execute Lexer? (Y/N): "
    $aws = Read-Host

    if ($aws -eq 'Y') {
        java -cp $CLASS_PATH $JAVA_CLASS $INPUT_FILE
    } elseif ($aws -ne 'N') {
        Write-Host "Enter a valid awnser."
    }
} while (-not($aws -eq 'Y' -or $aws -eq 'N'))