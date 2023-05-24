// Class use for returning tokens as objects
public class Token {
    private String token;
    private String lexeme;
    private int line;
    private int column;

    public String getLexeme() {
        return this.lexeme;
    }

    public String getToken() {
        return this.token;
    }

    public int getLine() {
        return this.line;
    }

    public int getColumn() {
        return this.column;
    }

    Token() {
        this.lexeme = "";
        this.token = "";
        this.line = 0;
        this.column = 0;
    }

    Token(String token, String lexeme, int line, int column) {
        this.lexeme = lexeme;
        this.token = token;
        this.line = line + 1;
        this.column = column + 1;
    }

    public String toString() {
        String symbol = "";
        if (token == "Identificador")
            symbol = String.format("%-25s | (%s)", token, lexeme);
        else if (token == "ERROR")
            symbol = String.format("\t(%s) Token no definido --> %s", token, lexeme);
        else
            symbol = String.format("%-25s | %s", token, lexeme);
        return symbol;
    }
}