echo =========================================================
echo Running $0 with $# arguments
echo [processID] $$
echo [arguments] $@
echo =========================================================

# echo "<=== info minima ===>"
# bundle info minima

echo "<=== serve incremental ===>"
jekyll serve --incremental