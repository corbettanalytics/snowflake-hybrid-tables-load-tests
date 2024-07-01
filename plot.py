import matplotlib.pyplot as plt
import pandas as pd


df = pd.read_json('load_test_results.json')
df.set_index('WINDOW', inplace=True)
result = df[['QUERIES_PER_SECOND', 'PCT_50', 'PCT_95', 'PCT_99']][df.index < 57]
print(result.head())

plt.plot(result[["PCT_50", "PCT_95", "PCT_99"]])
plt.show()
