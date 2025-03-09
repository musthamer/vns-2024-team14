# Gnuplot-Skript zur Darstellung der CPU-Auslastung von 19:00 bis 21:00 Uhr
set terminal pngcairo enhanced font "Arial,12" size 1600,800
set output '2.png'

# Achseneinstellungen
set title "CPU-Auslastung (19:00 bis 21:00 Uhr)"
set xlabel "Zeit"
set ylabel "CPU-Auslastung (%)"

set datafile separator "|"
set xdata time
set timefmt "%H:%M:%S"
set format x "%H:%M"

# Zeitbereich auf 19:00 bis 21:00 Uhr begrenzen
set xrange ["19:00:00":"21:00:00"]

# Y-Achse dynamisch skalieren, um Werte über 100% sichtbar zu machen
set yrange [0:130]

# Gitter aktivieren
set grid

# Optimierung der Legende
set key inside top left box font "Arial,10" spacing 1.5
set key width 1 height 1

# Linien zur besseren Lesbarkeit
set style data lines
set pointsize 0.3

# Benutzerdefinierte Farben (kräftig und gut unterscheidbar)
set style line 1 lc rgb "#1f77b4" lw 2  # Blau
set style line 2 lc rgb "#ff7f0e" lw 2  # Orange
set style line 3 lc rgb "#2ca02c" lw 2  # Grün
set style line 4 lc rgb "#d62728" lw 2  # Rot
set style line 5 lc rgb "#9467bd" lw 2  # Lila
set style line 6 lc rgb "#8c564b" lw 2  # Braun
set style line 7 lc rgb "#e377c2" lw 2  # Rosa

# Diagramm zeichnen mit kräftigen Farben und 'smooth csplines' für geglättete Kurven
plot '1.csv' using 1:($2*100) title "CPU Apache1" with lines ls 1 smooth csplines,\
     '1.csv' using 1:($3*100) title "CPU Apache2" with lines ls 2 smooth csplines,\
     '1.csv' using 1:($4*100) title "CPU Work" with lines ls 3 smooth csplines,\
     '1.csv' using 1:($5*100) title "CPU Haproxy" with lines ls 4 smooth csplines,\
     '1.csv' using 1:($6*100) title "CPU Redis" with lines ls 5 smooth csplines,\
     '1.csv' using 1:($7*100) title "CPU MariaDB" with lines ls 6 smooth csplines

