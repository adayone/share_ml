import sys

ex = sys.argv[1]
rate = sys.argv[2]
auc = open('model/%s_auc'%ex, 'r').read().split()[1]
print auc
pred = open('result/%s_pred'%ex, 'r')
rs = open('result/%s_pred_auc'%ex, 'w')
for line in pred.read().split('\n'):
    if len(line) < 1:
        continue
    line = line.strip()
    rs.write('%s\t%s\t%s\t%s\n'%(line, auc, ex, rate))
rs.close()

