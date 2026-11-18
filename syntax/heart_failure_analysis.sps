* ===== Kalp Yetmezligi Projesi v1 - analiz syntax'i =====.
* Sadece asagidaki klasor yolunu degistir, sonra Run > All.
CD 'C:\Users\Mehmet Hamza\Desktop\KALP ÖLÇÜM\heart-failure-spss'.

GET FILE='data\heart_failure.sav'.
DATASET NAME hf WINDOW=FRONT.

* 1. Hazirlama: EF (ESC 2021) ve yas gruplari.
RECODE ejection_fraction (LOWEST THRU 40=1) (41 THRU 49=2) (50 THRU HIGHEST=3) INTO ef_grp.
RECODE age (LOWEST THRU 59.999=1) (60 THRU 69.999=2) (70 THRU HIGHEST=3) INTO age_grp.
VARIABLE LABELS ef_grp 'EF grubu (ESC 2021)' /age_grp 'Yaş grubu'.
VALUE LABELS ef_grp 1 'HFrEF (<=40)' 2 'HFmrEF (41-49)' 3 'HFpEF (>=50)'
  /age_grp 1 '<60' 2 '60-69' 3 '70+'.
VARIABLE LEVEL ef_grp age_grp (ORDINAL).
EXECUTE.

* 2. Tanimlayici istatistikler.
FREQUENCIES VARIABLES=DEATH_EVENT ef_grp age_grp sex smoking anaemia diabetes high_blood_pressure
  /ORDER=ANALYSIS.
DESCRIPTIVES VARIABLES=age ejection_fraction serum_creatinine serum_sodium
    creatinine_phosphokinase platelets
  /STATISTICS=MEAN STDDEV MIN MAX.

* 3. Normallik kontrolu + medyan/ceyrekler (olen/yasayan gruplarinda).
EXAMINE VARIABLES=age ejection_fraction serum_creatinine serum_sodium
    creatinine_phosphokinase platelets BY DEATH_EVENT
  /PLOT BOXPLOT NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /PERCENTILES(25,50,75) HAVERAGE
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

* 4. Mann-Whitney U (soru 1).
NPAR TESTS
  /M-W= age ejection_fraction serum_creatinine serum_sodium
    creatinine_phosphokinase platelets BY DEATH_EVENT(0 1)
  /MISSING ANALYSIS.

* 5. Ki-kare (soru 2).
CROSSTABS
  /TABLES=age_grp ef_grp sex smoking anaemia diabetes high_blood_pressure BY DEATH_EVENT
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ PHI
  /CELLS=COUNT EXPECTED ROW
  /COUNT ROUND CELL.

* 6a. Kruskal-Wallis: H, sd ve p tablolari (soru 3).
NPAR TESTS /K-W=ejection_fraction serum_creatinine serum_sodium BY age_grp(1 3)
  /MISSING ANALYSIS.
NPAR TESTS /K-W=serum_creatinine serum_sodium age BY ef_grp(1 3)
  /MISSING ANALYSIS.

* 6b. Kruskal-Wallis: ikili karsilastirmalar (Dunn, Bonferroni).
NPTESTS
  /INDEPENDENT TEST (ejection_fraction serum_creatinine serum_sodium) GROUP (age_grp)
    KRUSKAL_WALLIS(COMPARE=PAIRWISE)
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE
  /CRITERIA ALPHA=0.05 CILEVEL=95.
NPTESTS
  /INDEPENDENT TEST (serum_creatinine serum_sodium age) GROUP (ef_grp)
    KRUSKAL_WALLIS(COMPARE=PAIRWISE)
  /MISSING SCOPE=ANALYSIS USERMISSING=EXCLUDE
  /CRITERIA ALPHA=0.05 CILEVEL=95.

* 7. Grafik: yas grubuna gore olum orani (0/1 ortalamasi = oran).
GRAPH /BAR(SIMPLE)=MEAN(DEATH_EVENT) BY age_grp.

* 8. Ciktiyi kaydet.
OUTPUT SAVE OUTFILE='output\heart_failure_output.spv'.
OUTPUT EXPORT
  /CONTENTS EXPORT=VISIBLE LAYERS=PRINTSETTING MODELVIEWS=PRINTSETTING
  /PDF DOCUMENTFILE='output\heart_failure_output.pdf' EMBEDBOOKMARKS=YES EMBEDFONTS=YES.
