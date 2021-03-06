# Commentaire

#################################
#COMMANDES POUR L'ENREGISTREMENT#
#################################
set terminal postscript eps enhanced solid "Helvetica" 23 size 5,3 # epslatex #size 1000,600set terminal postscript eps enhanced solid "Helvetica" 14
#set terminal epslatex
set termoption dash

############
# SAMPLING #
############
#Creations de commande de sampling
#set samples 50
#set isosamples 50

#set hidden3d

#f(x)=sqrt(x)

###########
# OPENING #
###########


file = './2fplots/uv-choc_rampe_2_CFL_05_1e3.dat'
sortie = 'uv-choc_implicite'
########
# AXES #
########

#set ticslevel(-2,0)
#Tiks
set xtics in

set mxtics 5
set ytics  in
set mytics 5
set grid xtics nomxtics ytics nomytics
# reverse met l'axe en sens inverse



########
# FONTS #
#########
# Mettre le font dans le terminal plutôt
#set xtics font "Times-Roman, 20"
#set ytics font "Times-Roman, 20"
#set title font "Times-Roman, 20"
#set ylabel font "Times-Roman, 20"
#set xlabel font "Times-Roman, 20"
#set key font "Times-Roman, 20"

#Dessin d'un graphique
#plot  file using 1:2 with lines title  'rho_analytique', file using 1:6 with lines title 'rho_num'
# get into multiplot mode
set style line 1 lw 3.5 lc rgb "blue" lt 3 
set style line 2 lt 3 lw 3.5 lc rgb "#DC143C"
set style line 3 linetype 1  lw 3.5 lc rgb "blue"
set style line 4 linetype 1 lw 3.5 lc rgb "#DC143C"
show style line

set key on inside top right box 
set xrange [*:*]  
set yrange [*:1.5]
set output sprintf('/netdata/H24872/rapport/Présentations/17_aout/graphiques/%s_rho.eps',sortie)
set xlabel "x [m]"
set ylabel "{/Symbol r} [kg /m^3]"
plot  file using 1:2 with lines ls 1  title  ' {/Symbol r}_1-analytique', file using 1:3 with lines ls 2  title  ' {/Symbol r}_2-analytique', file using 1:10 with lines ls 3  title  ' {/Symbol r}_1-A4', file using 1:11 with lines ls 4 title ' {/Symbol r}_2-A4'


set output sprintf('/netdata/H24872/rapport/Présentations/17_aout/graphiques/%s_u.eps',sortie)
set yrange [*:250]
set xlabel "x [m]"
set ylabel "u [m/s]"
set key on inside top left box 
plot  file using 1:4 with lines ls 1 title  ' u_1-analytique',  file using 1:5 with lines ls 2 title ' u_2-analytique', file using 1:12 with lines ls 3 title  ' u_1-A4',  file using 1:13 with lines ls 4 title ' u_2-A4'

set output sprintf('/netdata/H24872/rapport/Présentations/17_aout/graphiques/%s_p.eps',sortie)
set yrange [*:150000]
set xlabel "x [m]"
set ylabel "P [Pa]"
set key on inside top right box 
 plot  file using 1:6 with lines ls 1 title  ' P_1-analytique', file using 1:7 with lines ls 2 title ' P_2-analytique',  file using 1:14 with lines ls 3 title  ' P_1-A4', file using 1:15 with lines ls 4 title ' P_2-A4'

set output sprintf('/netdata/H24872/rapport/Présentations/17_aout/graphiques/%s_alpha.eps',sortie)
set yrange [*:1.5]
set xlabel "x [m]"
set ylabel "{/Symbol a}"
set key on inside top left box 
 plot  file using 1:8 with lines ls 1 title  ' {/Symbol a}_1-analytique', file using 1:9 with lines ls 2 title ' {/Symbol a}_2-analytique', file using 1:18 with lines ls 3 title  ' {/Symbol a}_1-A4', file using 1:19 with lines ls 4 title ' {/Symbol a}_2-A4'

#Enregistrement

