import sys
from sklearn import preprocessing
import sklearn.metrics
import numpy as np
import pandas as pd
from sklearn.ensemble import AdaBoostClassifier
from sklearn.kernel_approximation import RBFSampler
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier, NearestCentroid
from sklearn.pipeline import make_pipeline, make_union
from sklearn.preprocessing import Normalizer
from tpot.builtins import StackingEstimator

csv_path = sys.argv[1]
data = pd.read_csv(csv_path, sep=',', encoding='UTF-8-SIG')
features_saved = ['age', 'sex', 'cp', 'trestbps', 'chol', 'restecg', 'thalach', 'oldpeak', 'slope', 'ca', 'thal']
target = 'target'

pd_target = data[target]
pd_features = data.drop(columns=[target])
pd_features_cols = list(pd_features.columns.values)
for col in pd_features_cols:
    if col not in features_saved:
        pd_features = pd_features.drop(columns=[col])
        continue
    
training_features, testing_features, training_target, testing_target = train_test_split(pd_features, pd_target, random_state=42)
    
# Average CV score on the training set was: 0.8855695084243076
exported_pipeline = make_pipeline(
    Normalizer(norm="l2"),
    StackingEstimator(estimator=AdaBoostClassifier(algorithm="SAMME.R", learning_rate=0.1, n_estimators=100)),
    RBFSampler(gamma=0.6000000000000001),
    StackingEstimator(estimator=NearestCentroid(shrink_threshold=0.5)),
    KNeighborsClassifier(n_neighbors=26, p=1, weights="uniform")
)

exported_pipeline.fit(training_features, training_target)
results = exported_pipeline.predict(testing_features)

print("accuracy：", round(sklearn.metrics.accuracy_score(testing_target, results), 4))
for score, key in zip(["precision_score", "recall_score", "f1_score"], ["precision", 'recall', 'f1']):
    val = getattr(sklearn.metrics, score)(testing_target, results, average="macro", zero_division=0)
    if isinstance(val, np.float):
        print(f"{key}：", round(float(val), 4))
print("Prediction result in the testing dataset :")
print(testing_target.values == results)