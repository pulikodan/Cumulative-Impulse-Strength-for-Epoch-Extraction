Algorithms for extracting epochs or glottal closure
instants (GCIs) from voiced speech typically fall into two cate-
gories: i) ones which operate on linear prediction residual (LPR)
and ii) those which operate directly on the speech signal. While
the former class of algorithms (such as YAGA and DPI) tend to
be more accurate, the latter ones (such as ZFR and SEDREAMS)
tend to be more noise-robust. In this letter, a temporal measure
termed the cumulative impulse strength is proposed for locating
the impulses in a quasi-periodic impulse-sequence embedded in
noise. Subsequently, it is applied for detecting the GCIs from the
inverted integrated LPR using a recursive algorithm. Experiments
on two large corpora of speech with simultaneous electroglot-
tographic recordings demonstrate that the proposed method is
more robust to additive noise than the state-of-the-art algorithms,
despite operating on the LPR.
