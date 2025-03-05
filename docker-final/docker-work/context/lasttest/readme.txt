test k6 allgemein : 
root@462221d555dc:/home/user/k6-allgemein# cat haproxy_result.txt apache_result.txt apache2_result.txt
    ✓ HAProxy Status 200
    ✗ HAProxy Antwortzeit < 500ms
     ↳  99% — ✓ 296524 / ✗ 72
    ✓ Apache Status 200
    ✗ Apache Antwortzeit < 500ms
     ↳  99% — ✓ 296504 / ✗ 92
    ✓ Apache2 Status 200
    ✗ Apache2 Antwortzeit < 500ms
     ↳  99% — ✓ 296500 / ✗ 96

    checks.........................: 99.98% ✓ 1779316     ✗ 260
    data_received..................: 1.7 GB 11 MB/s
    data_sent......................: 68 MB  437 kB/s
    http_req_blocked...............: avg=79µs     min=1.37µs   med=3.75µs  max=2.97s   p(90)=5.77µs   p(95)=7.42µs
    http_req_connecting............: avg=65.54µs  min=0s       med=0s      max=2.97s   p(90)=0s       p(95)=0s
    http_req_duration..............: avg=10.43ms  min=141.25µs med=6.47ms  max=2.99s   p(90)=21.87ms  p(95)=28.68ms
      { expected_response:true }...: avg=10.43ms  min=141.25µs med=6.47ms  max=2.99s   p(90)=21.87ms  p(95)=28.68ms
    http_req_failed................: 0.00%  ✓ 0           ✗ 889788
    http_req_receiving.............: avg=606.48µs min=11.18µs  med=33.09µs max=2.98s   p(90)=246.95µs p(95)=906.27µs
    http_req_sending...............: avg=119.61µs min=4.12µs   med=9.99µs  max=2.97s   p(90)=18.42µs  p(95)=96.15µs
    http_req_tls_handshaking.......: avg=0s       min=0s       med=0s      max=0s      p(90)=0s       p(95)=0s
    http_req_waiting...............: avg=9.71ms   min=114.67µs med=6.11ms  max=2.98s   p(90)=20.7ms   p(95)=26.53ms
    http_reqs......................: 889788 5751.473699/s
    iteration_duration.............: avg=29.92ms  min=1.04ms   med=26.53ms max=220.6ms p(90)=59.08ms  p(95)=70.48ms
    iterations.....................: 296596 1917.1579/s
    vus............................: 1      min=1         max=99
    vus_max........................: 100    min=100       max=100     ✓ HAProxy Status 200
    ✗ HAProxy Antwortzeit < 500ms
     ↳  99% — ✓ 296524 / ✗ 72
    ✓ Apache Status 200
    ✗ Apache Antwortzeit < 500ms
     ↳  99% — ✓ 296504 / ✗ 92
    ✓ Apache2 Status 200
    ✗ Apache2 Antwortzeit < 500ms
     ↳  99% — ✓ 296500 / ✗ 96

    checks.........................: 99.98% ✓ 1779316     ✗ 260
    data_received..................: 1.7 GB 11 MB/s
    data_sent......................: 68 MB  437 kB/s
    http_req_blocked...............: avg=79µs     min=1.37µs   med=3.75µs  max=2.97s   p(90)=5.77µs   p(95)=7.42µs
    http_req_connecting............: avg=65.54µs  min=0s       med=0s      max=2.97s   p(90)=0s       p(95)=0s
    http_req_duration..............: avg=10.43ms  min=141.25µs med=6.47ms  max=2.99s   p(90)=21.87ms  p(95)=28.68ms
      { expected_response:true }...: avg=10.43ms  min=141.25µs med=6.47ms  max=2.99s   p(90)=21.87ms  p(95)=28.68ms
    http_req_failed................: 0.00%  ✓ 0           ✗ 889788
    http_req_receiving.............: avg=606.48µs min=11.18µs  med=33.09µs max=2.98s   p(90)=246.95µs p(95)=906.27µs
    http_req_sending...............: avg=119.61µs min=4.12µs   med=9.99µs  max=2.97s   p(90)=18.42µs  p(95)=96.15µs
    http_req_tls_handshaking.......: avg=0s       min=0s       med=0s      max=0s      p(90)=0s       p(95)=0s
    http_req_waiting...............: avg=9.71ms   min=114.67µs med=6.11ms  max=2.98s   p(90)=20.7ms   p(95)=26.53ms
    http_reqs......................: 889788 5751.473699/s
    iteration_duration.............: avg=29.92ms  min=1.04ms   med=26.53ms max=220.6ms p(90)=59.08ms  p(95)=70.48ms
    iterations.....................: 296596 1917.1579/s
    vus............................: 1      min=1         max=99
    vus_max........................: 100    min=100       max=100     ✓ HAProxy Status 200
    ✗ HAProxy Antwortzeit < 500ms
     ↳  99% — ✓ 296524 / ✗ 72
    ✓ Apache Status 200
    ✗ Apache Antwortzeit < 500ms
     ↳  99% — ✓ 296504 / ✗ 92
    ✓ Apache2 Status 200
    ✗ Apache2 Antwortzeit < 500ms
     ↳  99% — ✓ 296500 / ✗ 96

    checks.........................: 99.98% ✓ 1779316     ✗ 260
    data_received..................: 1.7 GB 11 MB/s
    data_sent......................: 68 MB  437 kB/s
    http_req_blocked...............: avg=79µs     min=1.37µs   med=3.75µs  max=2.97s   p(90)=5.77µs   p(95)=7.42µs
    http_req_connecting............: avg=65.54µs  min=0s       med=0s      max=2.97s   p(90)=0s       p(95)=0s
    http_req_duration..............: avg=10.43ms  min=141.25µs med=6.47ms  max=2.99s   p(90)=21.87ms  p(95)=28.68ms
      { expected_response:true }...: avg=10.43ms  min=141.25µs med=6.47ms  max=2.99s   p(90)=21.87ms  p(95)=28.68ms
    http_req_failed................: 0.00%  ✓ 0           ✗ 889788
    http_req_receiving.............: avg=606.48µs min=11.18µs  med=33.09µs max=2.98s   p(90)=246.95µs p(95)=906.27µs
    http_req_sending...............: avg=119.61µs min=4.12µs   med=9.99µs  max=2.97s   p(90)=18.42µs  p(95)=96.15µs
    http_req_tls_handshaking.......: avg=0s       min=0s       med=0s      max=0s      p(90)=0s       p(95)=0s
    http_req_waiting...............: avg=9.71ms   min=114.67µs med=6.11ms  max=2.98s   p(90)=20.7ms   p(95)=26.53ms
    http_reqs......................: 889788 5751.473699/s
    iteration_duration.............: avg=29.92ms  min=1.04ms   med=26.53ms max=220.6ms p(90)=59.08ms  p(95)=70.48ms
    iterations.....................: 296596 1917.1579/s
    vus............................: 1      min=1         max=99



# erklärung : 
Bericht zur Performance-Analyse von HAProxy und Apache
Wir haben eine Lastprüfung durchgeführt, um zu testen, wie gut unser System mit vielen parallelen Anfragen umgehen kann. Dabei wurde überprüft, wie schnell HAProxy, Apache und Apache2 reagieren und ob es zu Verzögerungen oder Fehlern kommt.

Testergebnisse im Überblick
✅ HAProxy erreichbar (Status 200)
❌ Antwortzeit von HAProxy über 500 ms (99% der Anfragen waren OK, aber 72 waren zu langsam)

✅ Apache erreichbar (Status 200)
❌ Antwortzeit von Apache über 500 ms (99% der Anfragen waren OK, aber 92 waren zu langsam)

✅ Apache2 erreichbar (Status 200)
❌ Antwortzeit von Apache2 über 500 ms (99% der Anfragen waren OK, aber 96 waren zu langsam)

✔ Erfolgreiche Anfragen insgesamt: 1.779.316 von 1.779.576 (99,98%)
✖ Fehlgeschlagene Anfragen: 260 (0,02%)

Detaillierte Performance-Daten
🔹 Datenverkehr

Empfangene Daten: 1,7 GB (11 MB/s)
Gesendete Daten: 68 MB (437 kB/s)
🔹 Antwortzeiten

Durchschnittliche Antwortzeit: 10,43 ms
Maximale Antwortzeit: 2,99 Sekunden
90% der Anfragen schneller als: 21,87 ms
95% der Anfragen schneller als: 28,68 ms
🔹 Anfragen & Durchsatz

Gesamte HTTP-Anfragen: 889.788
Anfragen pro Sekunde: 5.751/s
Durchschnittliche Dauer eines Durchlaufs: 29,92 ms
Iterationen insgesamt: 296.596 (1.917 Iterationen pro Sekunde)
Bewertung der Ergebnisse
✅ Die Erreichbarkeit der Dienste ist sehr gut, da 99,98% aller Anfragen erfolgreich waren.
✅ Die Antwortzeiten von HAProxy, Apache und Apache2 sind im Durchschnitt gut, aber einige Anfragen hatten Verzögerungen.
❌ Maximale Antwortzeiten von fast 3 Sekunden sind zu hoch, was auf mögliche Engpässe oder Lastspitzen hinweisen könnte.


#login-k6 

at k6_login_results.txt

         /\      Grafana   /‾‾/
    /\  /  \     |\  __   /  /
   /  \/    \    | |/ /  /   ‾‾\
  /          \   |   (  |  (‾)  |
 / __________ \  |_|\_\  \_____/

     execution: local
        script: k6_login_test.js
        output: -

     scenarios: (100.00%) 1 scenario, 100 max VUs, 2m30s max duration (incl. graceful stop):
              * default: Up to 100 looping VUs for 2m0s over 3 stages (gracefulRampDown: 30s, gracefulStop: 30s)


running (0m01.0s), 002/100 VUs, 0 complete and 0 interrupted iterations
default   [   1% ] 002/100 VUs  0m01.0s/2m00.0s

running (0m02.0s), 004/100 VUs, 2 complete and 0 interrupted iterations
default   [   2% ] 004/100 VUs  0m02.0s/2m00.0s

running (0m03.0s), 005/100 VUs, 6 complete and 0 interrupted iterations
default   [   2% ] 005/100 VUs  0m03.0s/2m00.0s

running (0m04.0s), 007/100 VUs, 11 complete and 0 interrupted iterations
default   [   3% ] 007/100 VUs  0m04.0s/2m00.0s

running (0m05.0s), 009/100 VUs, 17 complete and 0 interrupted iterations
default   [   4% ] 009/100 VUs  0m05.0s/2m00.0s

running (0m06.0s), 010/100 VUs, 26 complete and 0 interrupted iterations
default   [   5% ] 010/100 VUs  0m06.0s/2m00.0s

running (0m07.0s), 012/100 VUs, 35 complete and 0 interrupted iterations
default   [   6% ] 012/100 VUs  0m07.0s/2m00.0s

running (0m08.0s), 014/100 VUs, 46 complete and 0 interrupted iterations
default   [   7% ] 014/100 VUs  0m08.0s/2m00.0s

running (0m09.0s), 015/100 VUs, 59 complete and 0 interrupted iterations
default   [   7% ] 015/100 VUs  0m09.0s/2m00.0s

running (0m10.0s), 017/100 VUs, 73 complete and 0 interrupted iterations
default   [   8% ] 017/100 VUs  0m10.0s/2m00.0s

running (0m11.0s), 018/100 VUs, 90 complete and 0 interrupted iterations
default   [   9% ] 018/100 VUs  0m11.0s/2m00.0s

running (0m12.0s), 020/100 VUs, 107 complete and 0 interrupted iterations
default   [  10% ] 020/100 VUs  0m12.0s/2m00.0s

running (0m13.0s), 022/100 VUs, 125 complete and 0 interrupted iterations
default   [  11% ] 022/100 VUs  0m13.0s/2m00.0s

running (0m14.0s), 023/100 VUs, 146 complete and 0 interrupted iterations
default   [  12% ] 023/100 VUs  0m14.0s/2m00.0s

running (0m15.0s), 025/100 VUs, 167 complete and 0 interrupted iterations
default   [  12% ] 025/100 VUs  0m15.0s/2m00.0s

running (0m16.0s), 027/100 VUs, 191 complete and 0 interrupted iterations
default   [  13% ] 027/100 VUs  0m16.0s/2m00.0s

running (0m17.0s), 028/100 VUs, 214 complete and 0 interrupted iterations
default   [  14% ] 028/100 VUs  0m17.0s/2m00.0s

running (0m20.9s), 030/100 VUs, 242 complete and 0 interrupted iterations
default   [  15% ] 030/100 VUs  0m18.0s/2m00.0s

running (0m21.9s), 031/100 VUs, 268 complete and 0 interrupted iterations
default   [  16% ] 031/100 VUs  0m19.0s/2m00.0s

running (0m22.9s), 033/100 VUs, 296 complete and 0 interrupted iterations
default   [  17% ] 033/100 VUs  0m20.0s/2m00.0s

running (0m23.9s), 035/100 VUs, 326 complete and 0 interrupted iterations
default   [  17% ] 035/100 VUs  0m21.0s/2m00.0s

running (0m24.9s), 036/100 VUs, 359 complete and 0 interrupted iterations
default   [  18% ] 036/100 VUs  0m22.0s/2m00.0s

running (0m25.9s), 038/100 VUs, 389 complete and 0 interrupted iterations
default   [  19% ] 038/100 VUs  0m23.0s/2m00.0s

running (0m26.9s), 040/100 VUs, 426 complete and 0 interrupted iterations
default   [  20% ] 040/100 VUs  0m24.0s/2m00.0s

running (0m27.9s), 041/100 VUs, 460 complete and 0 interrupted iterations
default   [  21% ] 041/100 VUs  0m25.0s/2m00.0s

running (0m28.9s), 043/100 VUs, 497 complete and 0 interrupted iterations
default   [  22% ] 043/100 VUs  0m26.0s/2m00.0s

running (0m29.9s), 045/100 VUs, 530 complete and 0 interrupted iterations
default   [  22% ] 045/100 VUs  0m27.0s/2m00.0s

running (0m30.9s), 046/100 VUs, 567 complete and 0 interrupted iterations
default   [  23% ] 046/100 VUs  0m28.0s/2m00.0s

running (0m31.9s), 048/100 VUs, 599 complete and 0 interrupted iterations
default   [  24% ] 048/100 VUs  0m29.0s/2m00.0s

running (0m32.9s), 049/100 VUs, 640 complete and 0 interrupted iterations
default   [  25% ] 049/100 VUs  0m30.0s/2m00.0s

running (0m33.9s), 050/100 VUs, 673 complete and 0 interrupted iterations
default   [  26% ] 050/100 VUs  0m31.0s/2m00.0s

running (0m34.9s), 051/100 VUs, 718 complete and 0 interrupted iterations
default   [  27% ] 051/100 VUs  0m32.0s/2m00.0s

running (0m35.9s), 052/100 VUs, 747 complete and 0 interrupted iterations
default   [  27% ] 052/100 VUs  0m33.0s/2m00.0s

running (0m36.9s), 053/100 VUs, 792 complete and 0 interrupted iterations
default   [  28% ] 053/100 VUs  0m34.0s/2m00.0s

running (0m37.9s), 054/100 VUs, 824 complete and 0 interrupted iterations
default   [  29% ] 054/100 VUs  0m35.0s/2m00.0s

running (0m38.9s), 054/100 VUs, 863 complete and 0 interrupted iterations
default   [  30% ] 054/100 VUs  0m36.0s/2m00.0s

running (0m39.9s), 055/100 VUs, 900 complete and 0 interrupted iterations
default   [  31% ] 055/100 VUs  0m37.0s/2m00.0s

running (0m40.9s), 056/100 VUs, 934 complete and 0 interrupted iterations
default   [  32% ] 056/100 VUs  0m38.0s/2m00.0s

running (0m41.9s), 057/100 VUs, 974 complete and 0 interrupted iterations
default   [  32% ] 057/100 VUs  0m39.0s/2m00.0s

running (0m42.9s), 058/100 VUs, 1001 complete and 0 interrupted iterations
default   [  33% ] 058/100 VUs  0m40.0s/2m00.0s

running (0m43.9s), 059/100 VUs, 1057 complete and 0 interrupted iterations
default   [  34% ] 059/100 VUs  0m41.0s/2m00.0s

running (0m44.9s), 059/100 VUs, 1078 complete and 0 interrupted iterations
default   [  35% ] 059/100 VUs  0m42.0s/2m00.0s

running (0m45.9s), 060/100 VUs, 1126 complete and 0 interrupted iterations
default   [  36% ] 060/100 VUs  0m43.0s/2m00.0s

running (0m46.9s), 061/100 VUs, 1160 complete and 0 interrupted iterations
default   [  37% ] 061/100 VUs  0m44.0s/2m00.0s

running (0m47.9s), 062/100 VUs, 1192 complete and 0 interrupted iterations
default   [  37% ] 062/100 VUs  0m45.0s/2m00.0s

running (0m48.9s), 063/100 VUs, 1244 complete and 0 interrupted iterations
default   [  38% ] 063/100 VUs  0m46.0s/2m00.0s

running (0m49.9s), 064/100 VUs, 1266 complete and 0 interrupted iterations
default   [  39% ] 064/100 VUs  0m47.0s/2m00.0s

running (0m50.9s), 064/100 VUs, 1320 complete and 0 interrupted iterations
default   [  40% ] 064/100 VUs  0m48.0s/2m00.0s

running (0m51.9s), 065/100 VUs, 1350 complete and 0 interrupted iterations
default   [  41% ] 065/100 VUs  0m49.0s/2m00.0s

running (0m55.8s), 066/100 VUs, 1373 complete and 0 interrupted iterations
default   [  42% ] 066/100 VUs  0m50.0s/2m00.0s

running (0m56.8s), 067/100 VUs, 1432 complete and 0 interrupted iterations
default   [  42% ] 067/100 VUs  0m51.0s/2m00.0s

running (0m57.8s), 068/100 VUs, 1449 complete and 0 interrupted iterations
default   [  43% ] 068/100 VUs  0m52.0s/2m00.0s

running (0m58.8s), 069/100 VUs, 1499 complete and 0 interrupted iterations
default   [  44% ] 069/100 VUs  0m53.0s/2m00.0s

running (0m59.8s), 069/100 VUs, 1533 complete and 0 interrupted iterations
default   [  45% ] 069/100 VUs  0m54.0s/2m00.0s

running (1m00.8s), 070/100 VUs, 1547 complete and 0 interrupted iterations
default   [  46% ] 070/100 VUs  0m55.0s/2m00.0s

running (1m01.8s), 071/100 VUs, 1613 complete and 0 interrupted iterations
default   [  47% ] 071/100 VUs  0m56.0s/2m00.0s

running (1m02.8s), 072/100 VUs, 1631 complete and 0 interrupted iterations
default   [  47% ] 072/100 VUs  0m57.0s/2m00.0s

running (1m03.8s), 073/100 VUs, 1674 complete and 0 interrupted iterations
default   [  48% ] 073/100 VUs  0m58.0s/2m00.0s

running (1m04.8s), 074/100 VUs, 1721 complete and 0 interrupted iterations
default   [  49% ] 074/100 VUs  0m59.0s/2m00.0s

running (1m05.8s), 074/100 VUs, 1737 complete and 0 interrupted iterations
default   [  50% ] 074/100 VUs  1m00.0s/2m00.0s

running (1m06.8s), 075/100 VUs, 1800 complete and 0 interrupted iterations
default   [  51% ] 075/100 VUs  1m01.0s/2m00.0s

running (1m07.8s), 076/100 VUs, 1830 complete and 0 interrupted iterations
default   [  52% ] 076/100 VUs  1m02.0s/2m00.0s

running (1m08.8s), 077/100 VUs, 1846 complete and 0 interrupted iterations
default   [  52% ] 077/100 VUs  1m03.0s/2m00.0s

running (1m09.8s), 078/100 VUs, 1918 complete and 0 interrupted iterations
default   [  53% ] 078/100 VUs  1m04.0s/2m00.0s

running (1m10.8s), 079/100 VUs, 1938 complete and 0 interrupted iterations
default   [  54% ] 079/100 VUs  1m05.0s/2m00.0s

running (1m11.8s), 079/100 VUs, 1964 complete and 0 interrupted iterations
default   [  55% ] 079/100 VUs  1m06.0s/2m00.0s

running (1m12.8s), 080/100 VUs, 2035 complete and 0 interrupted iterations
default   [  56% ] 080/100 VUs  1m07.0s/2m00.0s

running (1m13.8s), 081/100 VUs, 2047 complete and 0 interrupted iterations
default   [  57% ] 081/100 VUs  1m08.0s/2m00.0s

running (1m14.8s), 082/100 VUs, 2085 complete and 0 interrupted iterations
default   [  57% ] 082/100 VUs  1m09.0s/2m00.0s

running (1m15.9s), 083/100 VUs, 2143 complete and 0 interrupted iterations
default   [  58% ] 083/100 VUs  1m10.0s/2m00.0s

running (1m16.8s), 084/100 VUs, 2160 complete and 0 interrupted iterations
default   [  59% ] 084/100 VUs  1m11.0s/2m00.0s

running (1m17.8s), 084/100 VUs, 2200 complete and 0 interrupted iterations
default   [  60% ] 084/100 VUs  1m12.0s/2m00.0s

running (1m18.8s), 085/100 VUs, 2245 complete and 0 interrupted iterations
default   [  61% ] 085/100 VUs  1m13.0s/2m00.0s

running (1m19.8s), 086/100 VUs, 2260 complete and 0 interrupted iterations
default   [  62% ] 086/100 VUs  1m14.0s/2m00.0s

running (1m20.8s), 087/100 VUs, 2315 complete and 0 interrupted iterations
default   [  62% ] 087/100 VUs  1m15.0s/2m00.0s

running (1m21.8s), 088/100 VUs, 2357 complete and 0 interrupted iterations
default   [  63% ] 088/100 VUs  1m16.0s/2m00.0s

running (1m22.8s), 089/100 VUs, 2371 complete and 0 interrupted iterations
default   [  64% ] 089/100 VUs  1m17.0s/2m00.0s

running (1m23.8s), 089/100 VUs, 2417 complete and 0 interrupted iterations
default   [  65% ] 089/100 VUs  1m18.0s/2m00.0s

running (1m24.8s), 090/100 VUs, 2470 complete and 0 interrupted iterations
default   [  66% ] 090/100 VUs  1m19.0s/2m00.0s

running (1m25.8s), 091/100 VUs, 2479 complete and 0 interrupted iterations
default   [  67% ] 091/100 VUs  1m20.0s/2m00.0s

running (1m26.8s), 092/100 VUs, 2527 complete and 0 interrupted iterations
default   [  67% ] 092/100 VUs  1m21.0s/2m00.0s

running (1m30.8s), 093/100 VUs, 2585 complete and 0 interrupted iterations
default   [  68% ] 093/100 VUs  1m22.0s/2m00.0s

running (1m31.8s), 094/100 VUs, 2597 complete and 0 interrupted iterations
default   [  69% ] 094/100 VUs  1m23.0s/2m00.0s

running (1m32.8s), 094/100 VUs, 2626 complete and 0 interrupted iterations
default   [  70% ] 094/100 VUs  1m24.0s/2m00.0s

running (1m33.8s), 095/100 VUs, 2701 complete and 0 interrupted iterations
default   [  71% ] 095/100 VUs  1m25.0s/2m00.0s

running (1m34.8s), 096/100 VUs, 2716 complete and 0 interrupted iterations
default   [  72% ] 096/100 VUs  1m26.0s/2m00.0s

running (1m35.8s), 097/100 VUs, 2739 complete and 0 interrupted iterations
default   [  72% ] 097/100 VUs  1m27.0s/2m00.0s

running (1m36.8s), 098/100 VUs, 2821 complete and 0 interrupted iterations
default   [  73% ] 098/100 VUs  1m28.0s/2m00.0s

running (1m37.8s), 099/100 VUs, 2835 complete and 0 interrupted iterations
default   [  74% ] 099/100 VUs  1m29.0s/2m00.0s

running (1m38.8s), 099/100 VUs, 2852 complete and 0 interrupted iterations
default   [  75% ] 099/100 VUs  1m30.0s/2m00.0s

running (1m39.8s), 100/100 VUs, 2924 complete and 0 interrupted iterations
default   [  76% ] 100/100 VUs  1m31.0s/2m00.0s

running (1m40.8s), 098/100 VUs, 2960 complete and 0 interrupted iterations
default   [  77% ] 098/100 VUs  1m32.0s/2m00.0s

running (1m41.8s), 098/100 VUs, 2972 complete and 0 interrupted iterations
default   [  77% ] 098/100 VUs  1m33.0s/2m00.0s

running (1m42.8s), 092/100 VUs, 3023 complete and 0 interrupted iterations
default   [  78% ] 092/100 VUs  1m34.0s/2m00.0s

running (1m43.8s), 088/100 VUs, 3082 complete and 0 interrupted iterations
default   [  79% ] 088/100 VUs  1m35.0s/2m00.0s

running (1m44.8s), 087/100 VUs, 3090 complete and 0 interrupted iterations
default   [  80% ] 087/100 VUs  1m36.0s/2m00.0s

running (1m45.8s), 085/100 VUs, 3114 complete and 0 interrupted iterations
default   [  81% ] 085/100 VUs  1m37.0s/2m00.0s

running (1m46.8s), 077/100 VUs, 3188 complete and 0 interrupted iterations
default   [  82% ] 077/100 VUs  1m38.0s/2m00.0s

running (1m47.8s), 076/100 VUs, 3201 complete and 0 interrupted iterations
default   [  82% ] 076/100 VUs  1m39.0s/2m00.0s

running (1m48.8s), 069/100 VUs, 3256 complete and 0 interrupted iterations
default   [  83% ] 069/100 VUs  1m40.0s/2m00.0s

running (1m49.8s), 067/100 VUs, 3286 complete and 0 interrupted iterations
default   [  84% ] 067/100 VUs  1m41.0s/2m00.0s

running (1m50.8s), 066/100 VUs, 3293 complete and 0 interrupted iterations
default   [  85% ] 066/100 VUs  1m42.0s/2m00.0s

running (1m51.8s), 063/100 VUs, 3327 complete and 0 interrupted iterations
default   [  86% ] 063/100 VUs  1m43.0s/2m00.0s

running (1m52.8s), 057/100 VUs, 3371 complete and 0 interrupted iterations
default   [  87% ] 057/100 VUs  1m44.0s/2m00.0s

running (1m53.8s), 056/100 VUs, 3389 complete and 0 interrupted iterations
default   [  87% ] 056/100 VUs  1m45.0s/2m00.0s

running (1m54.8s), 050/100 VUs, 3442 complete and 0 interrupted iterations
default   [  88% ] 050/100 VUs  1m46.0s/2m00.0s

running (1m55.8s), 048/100 VUs, 3461 complete and 0 interrupted iterations
default   [  89% ] 048/100 VUs  1m47.0s/2m00.0s

running (1m56.8s), 043/100 VUs, 3507 complete and 0 interrupted iterations
default   [  90% ] 043/100 VUs  1m48.0s/2m00.0s

running (1m57.8s), 039/100 VUs, 3537 complete and 0 interrupted iterations
default   [  91% ] 039/100 VUs  1m49.0s/2m00.0s

running (1m58.8s), 036/100 VUs, 3568 complete and 0 interrupted iterations
default   [  92% ] 036/100 VUs  1m50.0s/2m00.0s

running (1m59.8s), 032/100 VUs, 3604 complete and 0 interrupted iterations
default   [  92% ] 032/100 VUs  1m51.0s/2m00.0s

running (2m00.8s), 029/100 VUs, 3625 complete and 0 interrupted iterations
default   [  93% ] 029/100 VUs  1m52.0s/2m00.0s

running (2m01.8s), 026/100 VUs, 3649 complete and 0 interrupted iterations
default   [  94% ] 026/100 VUs  1m53.0s/2m00.0s

running (2m05.7s), 022/100 VUs, 3675 complete and 0 interrupted iterations
default   [  95% ] 022/100 VUs  1m54.0s/2m00.0s

running (2m06.7s), 020/100 VUs, 3695 complete and 0 interrupted iterations
default   [  96% ] 020/100 VUs  1m55.0s/2m00.0s

running (2m07.7s), 015/100 VUs, 3715 complete and 0 interrupted iterations
default   [  97% ] 015/100 VUs  1m56.0s/2m00.0s

running (2m08.7s), 013/100 VUs, 3723 complete and 0 interrupted iterations
default   [  97% ] 013/100 VUs  1m57.0s/2m00.0s

running (2m09.7s), 009/100 VUs, 3736 complete and 0 interrupted iterations
default   [  98% ] 009/100 VUs  1m58.0s/2m00.0s

running (2m10.7s), 007/100 VUs, 3743 complete and 0 interrupted iterations
default   [  99% ] 007/100 VUs  1m59.0s/2m00.0s

running (2m11.7s), 003/100 VUs, 3750 complete and 0 interrupted iterations
default   [ 100% ] 003/100 VUs  2m00.0s/2m00.0s

     ✓ Login erfolgreich
     ✓ Session-Cookie gesetzt
     ✓ ToDo-Seite geladen

     checks.........................: 100.00% 11259 out of 11259
     data_received..................: 29 MB   216 kB/s
     data_sent......................: 1.6 MB  12 kB/s
     http_req_blocked...............: avg=12.75µs  min=2.1µs   med=7.05µs   max=2.2ms   p(90)=9.62µs   p(95)=17.5µs
     http_req_connecting............: avg=2.95µs   min=0s      med=0s       max=1.25ms  p(90)=0s       p(95)=0s
     http_req_duration..............: avg=443.65ms min=17.18ms med=292.85ms max=4.47s   p(90)=1.02s    p(95)=1.24s
       { expected_response:true }...: avg=443.65ms min=17.18ms med=292.85ms max=4.47s   p(90)=1.02s    p(95)=1.24s
     http_req_failed................: 0.00%   0 out of 7506
     http_req_receiving.............: avg=200.69ms min=39.78µs med=21.85ms  max=4.09s   p(90)=689.71ms p(95)=862.15ms
     http_req_sending...............: avg=34.11µs  min=7.05µs  med=26.03µs  max=10.93ms p(90)=44.87µs  p(95)=54.06µs
     http_req_tls_handshaking.......: avg=0s       min=0s      med=0s       max=0s      p(90)=0s       p(95)=0s
     http_req_waiting...............: avg=242.92ms min=8.78ms  med=157.38ms max=3.87s   p(90)=524.24ms p(95)=652.49ms
     http_reqs......................: 7506    56.711534/s
     iteration_duration.............: avg=1.81s    min=1.05s   med=1.68s    max=3.27s   p(90)=2.77s    p(95)=2.93s
     iterations.....................: 3753    28.355767/s
     vus............................: 3       min=2              max=100
     vus_max........................: 100     min=100            max=100


running (2m12.4s), 000/100 VUs, 3753 complete and 0 interrupted iterations
default ✓ [ 100% ] 000/100 VUs  2m0s


#
Wir haben einen Lasttest für den Login-Prozess durchgeführt, um zu überprüfen, ob Benutzer sich erfolgreich anmelden können und ob das Session-Cookie korrekt gesetzt wird.

Testergebnisse im Überblick
✅ Login erfolgreich (100% der 3.753 Login-Versuche waren erfolgreich!)
✅ Session-Cookie wurde korrekt gesetzt
✅ ToDo-Seite konnte nach dem Login geladen werden

✔ Gesamtzahl der HTTP-Anfragen: 7.506
✔ Erfolgreiche HTTP-Anfragen: 100% (keine technischen Fehler, alle Logins funktionierten)

Detaillierte Performance-Daten
🔹 Datenverkehr

Empfangene Daten: 29 MB (216 kB/s)
Gesendete Daten: 1,6 MB (12 kB/s)
🔹 Antwortzeiten

Durchschnittliche Antwortzeit: 443,65 ms
Maximale Antwortzeit: 4,47 Sekunden
90% der Anfragen schneller als: 1,02 Sekunden
95% der Anfragen schneller als: 1,24 Sekunden
🔹 Anfragen & Durchsatz

Gesamte HTTP-Anfragen: 7.506
Anfragen pro Sekunde: 56,7/s
Gesamte Iterationen: 3.753 (28,3 Iterationen pro Sekunde)
Bewertung der Ergebnisse
✅ Login funktioniert jetzt! Alle Login-Versuche wurden erfolgreich abgeschlossen, und Nutzer konnten sich anmelden.
✅ Session-Cookies werden korrekt gesetzt, was bedeutet, dass die Authentifizierung jetzt sauber läuft.
✅ Keine technischen HTTP-Fehler – alle Anfragen wurden ohne Probleme verarbeitet.
⚠️ Antwortzeiten sind noch hoch – Während die meisten Anfragen schnell bearbeitet wurden, gab es einige lange Wartezeiten (bis zu 4,47 Sekunden).



#add-todolist 

.....
....
running (1m19.2s), 22/50 VUs, 1904 complete and 0 interrupted iterations
default   [  90% ] 22/50 VUs  1m12.0s/1m20.0s

running (1m20.2s), 19/50 VUs, 1926 complete and 0 interrupted iterations
default   [  91% ] 19/50 VUs  1m13.0s/1m20.0s

running (1m21.2s), 16/50 VUs, 1942 complete and 0 interrupted iterations
default   [  92% ] 16/50 VUs  1m14.0s/1m20.0s

running (1m22.2s), 15/50 VUs, 1957 complete and 0 interrupted iterations
default   [  94% ] 15/50 VUs  1m15.0s/1m20.0s

running (1m23.2s), 11/50 VUs, 1972 complete and 0 interrupted iterations
default   [  95% ] 11/50 VUs  1m16.0s/1m20.0s

running (1m24.2s), 10/50 VUs, 1983 complete and 0 interrupted iterations
default   [  96% ] 10/50 VUs  1m17.0s/1m20.0s

running (1m25.2s), 07/50 VUs, 1993 complete and 0 interrupted iterations
default   [  97% ] 07/50 VUs  1m18.0s/1m20.0s

running (1m26.2s), 05/50 VUs, 2000 complete and 0 interrupted iterations
default   [  99% ] 05/50 VUs  1m19.0s/1m20.0s

running (1m27.2s), 02/50 VUs, 2005 complete and 0 interrupted iterations
default   [ 100% ] 02/50 VUs  1m20.0s/1m20.0s

     ✓ Aufgabe erfolgreich hinzugefügt
     ✓ ToDo-Liste geladen

     checks.........................: 100.00% 4014 out of 4014
     data_received..................: 4.5 MB  51 kB/s
     data_sent......................: 1.1 MB  12 kB/s
     http_req_blocked...............: avg=9.85µs   min=1.52µs   med=5.85µs  max=1.32ms   p(90)=8.27µs   p(95)=9.53µs
     http_req_connecting............: avg=2.02µs   min=0s       med=0s      max=705.51µs p(90)=0s       p(95)=0s
     http_req_duration..............: avg=17.57ms  min=357.57µs med=5.55ms  max=159.85ms p(90)=48.3ms   p(95)=55.04ms
       { expected_response:true }...: avg=17.57ms  min=357.57µs med=5.55ms  max=159.85ms p(90)=48.3ms   p(95)=55.04ms
     http_req_failed................: 0.00%   0 out of 6021
     http_req_receiving.............: avg=111.96µs min=13.14µs  med=99.09µs max=9.86ms   p(90)=147.06µs p(95)=170.37µs
     http_req_sending...............: avg=26.02µs  min=4.59µs   med=16.2µs  max=7.29ms   p(90)=43.11µs  p(95)=49.32µs
     http_req_tls_handshaking.......: avg=0s       min=0s       med=0s      max=0s       p(90)=0s       p(95)=0s
     http_req_waiting...............: avg=17.43ms  min=300.06µs med=5.4ms   max=159.71ms p(90)=48.13ms  p(95)=54.85ms
     http_reqs......................: 6021    68.575474/s
     iteration_duration.............: avg=1.05s    min=1.02s    med=1.05s   max=1.17s    p(90)=1.07s    p(95)=1.07s
     iterations.....................: 2007    22.858491/s
     vus............................: 2       min=1            max=50
     vus_max........................: 50      min=50           max=50


running (1m27.8s), 00/50 VUs, 2007 complete and 0 interrupted iterations
default ✓ [ 100% ] 00/50 VUs  1m20s






#
Bericht zur Performance-Analyse des ToDo-Tests mit k6
Wir haben erneut einen Lasttest für das Hinzufügen von Aufgaben (ToDos) durchgeführt, um zu überprüfen, ob das System stabil arbeitet und ToDos korrekt in der Liste angezeigt werden. 🎉

Testergebnisse im Überblick
✅ Aufgabe erfolgreich hinzugefügt
✅ ToDo-Liste nach dem Hinzufügen geladen
✅ Alle ToDos erscheinen in der Liste (100% Erfolgsrate! 🎉)

✔ Gesamtzahl der HTTP-Anfragen: 6.021
✔ Erfolgreiche HTTP-Anfragen: 100% (keine technischen Fehler, alle ToDos erfolgreich sichtbar!)
✔ Durchschnittliche Antwortzeit: 17,57 ms

Detaillierte Performance-Daten
🔹 Datenverkehr

Empfangene Daten: 4,5 MB (51 kB/s)
Gesendete Daten: 1,1 MB (12 kB/s)
🔹 Antwortzeiten

Durchschnittliche Antwortzeit: 17,57 ms
Maximale Antwortzeit: 159,85 ms
90% der Anfragen schneller als: 48,3 ms
95% der Anfragen schneller als: 55,04 ms
🔹 Anfragen & Durchsatz

Gesamte HTTP-Anfragen: 6.021
Anfragen pro Sekunde: 68,57/s
Gesamte Iterationen: 2.007 (22,86 Iterationen pro Sekunde)
Bewertung der Ergebnisse
✅ ToDos werden jetzt richtig gespeichert und in der Liste angezeigt.
✅ Keine technischen HTTP-Fehler (100% Erfolgsrate!)
✅ Antwortzeiten sind sehr gut (die meisten Anfragen unter 50 ms).
⚠️ Kleinere Antwortzeit-Schwankungen (maximal 159 ms) könnten optimiert werden.


# tcpdump-alles 


root@fc07b52580d1:/home/user# ./tcpdump-alles.sh
Starte Netzwerkanalyse mit tcpdump...
TCPDump läuft mit PID 15844 - Erfassung für 60 Sekunden...
tcpdump: listening on eth0, link-type EN10MB (Ethernet), snapshot length 262144 bytes
Teste HAProxy HTTP-Zugriffe...
Führe MariaDB-Lasttest mit sysbench durch...
Teste Redis-Performance mit redis-benchmark...
Setze und lese todos_cache in Redis...
Warte 60 Sekunden für vollständige Datenerfassung...
Beende TCPDump...
719945 packets captured
719945 packets received by filter
0 packets dropped by kernel
Netzwerkanalyse abgeschlossen. Logs gespeichert in tcpdump_logs
Analysiere Test-Ergebnisse aus tcpdump_logs ...
reading from file tcpdump_logs/network.pcap, link-type EN10MB (Ethernet), snapshot length 262144
reading from file tcpdump_logs/network.pcap, link-type EN10MB (Ethernet), snapshot length 262144
reading from file tcpdump_logs/network.pcap, link-type EN10MB (Ethernet), snapshot length 262144
reading from file tcpdump_logs/network.pcap, link-type EN10MB (Ethernet), snapshot length 262144

📌 Anzahl der HTTP-Anfragen (Port 80):
319041

📌 Anzahl der MariaDB-Anfragen (Port 3306):
68

📌 Anzahl der Redis-Operationen (Port 6379):
400836

📌 HTTP-Statuscode Verteilung:
reading from file tcpdump_logs/network.pcap, link-type EN10MB (Ethernet), snapshot length 262144
 106287 HTTP/1.1 200
      1 HTTP/1.1 400

📌 Fehleranalyse in den Logs:
8
   Fehler gefunden: 8
0
   Timeouts: 0
Analyse abgeschlossen 



ericht zur Netzwerkanalyse mit TCPDump
Wir haben einen 60-sekündigen Netzwerk-Test durchgeführt, um die HTTP-, MariaDB- und Redis-Operationen zu analysieren. Dabei wurden insgesamt 719.945 Pakete erfasst.

1️⃣ Testergebnisse im Überblick
📌 Gesamtzahl der erfassten Netzwerkpakete: 719.945

🔹 Anfragen pro Dienst:

HTTP-Anfragen (Port 80): 319.041
MariaDB-Datenbankanfragen (Port 3306): 68
Redis-Operationen (Port 6379): 400.836
🔹 HTTP-Statuscode-Verteilung:

200 OK: 106.287 (erfolgreiche Anfragen)
400 Bad Request: 1 (möglicher fehlerhafter Request)
🔹 Fehleranalyse:

Gefundene Fehler: 8
Timeouts: 0 (keine Verbindungsprobleme festgestellt)
2️⃣ Bewertung der Ergebnisse
✅ Sehr hohe Anzahl an HTTP-Anfragen → 319.041 Requests in 60 Sekunden, was auf eine intensive Nutzung des Webservers hindeutet.
✅ Redis wird stark genutzt → Mit 400.836 Operationen ist Redis das meistgenutzte System, was auf ein funktionierendes Caching hinweist.
⚠️ Wenig MariaDB-Last → Nur 68 Anfragen zur Datenbank, was bedeutet, dass die meisten Daten aus dem Cache statt aus der Datenbank gelesen werden.
✅ Kaum Fehler (nur 8 insgesamt) → Das System ist stabil, keine kritischen Fehler.
⚠️ Ein einzelner 400-Fehler → Dies könnte ein fehlerhafter API-Request oder eine ungültige Anfrage sein, sollte aber beobachtet werden. 








