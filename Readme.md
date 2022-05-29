The Coq Proof Assistant, version 8.14.1
compiled with OCaml 4.13.1

In `ok/`, we use `unsigned *`, which works fine.

In `wrong/`, we use `int *`, where `forward` failed.

```
cd ok/
clightgen -normalize mergesort.c
make
emacs Verif_mergesort.v
```

