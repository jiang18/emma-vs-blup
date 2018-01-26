# emma_vs_blup
A quick comparison in P values between EMMA and BLUP through simulation

In routine single-marker mixed model association tests, we generally treat marker effects as fixed and use Wald tests or LRTs to compute the P values, either with an exact method (like EMMA, GEMMA, etc.) or in an approximate way (like EMMAX).

Recently, I saw studies which use BLUP/SE(BLUP) to build Wald tests and claim the same or even better performance (regarding power and specificity) compared to routine approaches. This is interesting. To empirically check the performance of BLUP/SE(BLUP), I wrote an R script to compare the P values from EMMA/EMMAX and BLUP.

# A quick observation
BLUP/SE(BLUP) can generate almost the same P values as EMMA/EMMAX for markers with no/little effect. However, a deflation of -logP in BLUP is observed for large effects, and the larger the -logP is, the bigger the deflation is.
