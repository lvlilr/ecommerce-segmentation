"""New V2 Python-equivalent reproduction of the original R transaction clustering."""
from pathlib import Path
import argparse,json
import pandas as pd
from sklearn.cluster import KMeans
import matplotlib;matplotlib.use("Agg")
import matplotlib.pyplot as plt
p=argparse.ArgumentParser();p.add_argument("--data",required=True);p.add_argument("--output",default="results");a=p.parse_args()
out=Path(a.output);out.mkdir(exist_ok=True,parents=True);d=pd.read_csv(a.data);clean=d.dropna(subset=["Sales","Profit"]).copy();X=clean[["Sales","Profit"]]
m=KMeans(n_clusters=3,n_init=25,random_state=123,algorithm="lloyd").fit(X)
ordered=sorted(range(3),key=lambda k:m.cluster_centers_[k,0]);mapping={old:i+1 for i,old in enumerate(ordered)};clean["Segment"]=[mapping[int(x)] for x in m.labels_]
stats=clean.groupby("Segment").agg(count=("Sales","size"),mean_sales=("Sales","mean"),mean_profit=("Profit","mean"));stats.to_csv(out/"cluster_statistics.csv")
(out/"summary.json").write_text(json.dumps({"raw_rows":len(d),"raw_columns":len(d.columns),"clustering_rows":len(clean),"inertia":m.inertia_,"seed":123,"n_init":25,"engine":"scikit-learn Lloyd; not original R Hartigan-Wong"},indent=2))
fig,ax=plt.subplots(figsize=(7,4));
for k,g in clean.groupby("Segment"):ax.scatter(g.Sales,g.Profit,s=8,alpha=.3,label=str(k))
ax.set(xlabel="Sales (USD)",ylabel="Profit (USD)",title="Transaction segmentation");ax.legend(title="Segment");fig.tight_layout();fig.savefig(out/"transaction_segments.png",dpi=160)
print(stats.to_string());print("Inertia:",m.inertia_)
