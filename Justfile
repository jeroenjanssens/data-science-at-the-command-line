set shell := ["bash", "-euo", "pipefail", "-c"]

book := "book/2.5e"

# Serve the rendered book (book/2.5e/_book/) at http://localhost:PORT and open it
preview port="8000":
    @echo "Serving {{book}}/_book/ at http://localhost:{{port}} (Ctrl-C to stop)"
    @(sleep 1 && open "http://localhost:{{port}}") &
    python3 -m http.server {{port}} --bind 127.0.0.1 --directory {{book}}/_book
