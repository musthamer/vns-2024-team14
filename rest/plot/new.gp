set terminal pngcairo size 1200,600 enhanced font 'Arial,12'
set output 'server_last.png'

set title "Server-CPU über die Zeit"
set xlabel "Zeit (Minuten)"
set ylabel "CPU-Last (%)"
set grid
set key outside right
set datafile separator ","

# Zeitachse in Minuten skalieren und die Schrittweite anpassen
set xtics 5   # Zeigt die Achsenmarkierungen alle 5 Minuten
set mxtics 2  # Zusätzliche kleine Markierungen für bessere Orientierung
set format x "%.1f"
set xrange [0:*] 

plot "cpu_usage.csv" using ($1/60):2 with lines title "Apache-1" lw 2 linecolor rgb "#1f77b4", \
     "cpu_usage.csv" using ($1/60):3 with lines title "Apache-2" lw 2 linecolor rgb "#ff7f0e", \
     "cpu_usage.csv" using ($1/60):4 with lines title "Apache-3" lw 2 linecolor rgb "#2ca02c", \
     "cpu_usage.csv" using ($1/60):5 with lines title "HAProxy" lw 2 linecolor rgb "#d62728", \
     "cpu_usage.csv" using ($1/60):6 with lines title "MariaDB" lw 2 linecolor rgb "#9467bd", \
     "cpu_usage.csv" using ($1/60):7 with lines title "Redis" lw 2 linecolor rgb "#8c564b"

