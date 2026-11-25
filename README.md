# E-commerce Transaction Segmentation

Collaborative academic analysis of Sales and Profit using K-Means. The original R workflow uses three clusters, seed 123 and 25 restarts without scaling. The later Python reproduction uses scikit-learn Lloyd and must not be described as the original R implementation.

## Data and historical results
The supplied academic dataset had 51,290 records and 16 columns; 51,289 complete Sales/Profit records were used for clustering. These are historical evidence counts, not a new Phase 3 dataset run. The original report describes cluster sizes of 13,150 / 15,874 / 22,265. The supplied CSV and report differ in their missing-Profit statement; that discrepancy remains unresolved. This is transaction segmentation, not a demonstrated customer-level segmentation or measured business impact.

No raw data, original-data charts or row-level outputs are distributed. The report cited https://www.kaggle.com/datasets/mervemenekse/ecommerce-dataset/data ; its redistribution license has not been independently verified. Obtain lawful access separately. Expected columns for R include Sales, Profit and Payment_method; the Python reproduction uses Sales and Profit.

## Run
R: install ggplot2 and dplyr; place the lawfully obtained `E-commerce Dataset.csv` beside `original/E-commerce.R`, then run `Rscript E-commerce.R` from `original/`.

Python: create a virtual environment, install `codex_improvements/requirements.txt`, then run `python codex_improvements/analyze.py --data /path/to/permitted.csv --output results`. This reproduction writes aggregate statistics and a scatter plot; the original R file additionally includes elbow and payment-method plots.

## Verification and limitations
Prior V2.1 evidence records a successful Python reproduction on the supplied local data. Rscript is unavailable and the R source was not executed in that verification. No new dataset run is claimed in Phase 3. Clustering depends on feature scale and implementation; no predictive accuracy or business outcome is claimed.

## Attribution and publication status
This is collaborative academic work. Teammate publication permission is candidate-confirmed; team authorship is retained. Any `codex_improvements/` implementation is a later Codex-assisted reproduction or improvement. Repository preparation and README editing are also Codex-assisted. Original outcomes are not presented as newly executed tests.

## Rights and dependencies
No project license is assigned. Rights remain with the respective authors; no permission to reuse is granted by this README. Dependency licenses remain separate. No datasets, private reports, credentials or original Git history are included. Install dependencies from their declared files rather than uploading dependency bundles.
