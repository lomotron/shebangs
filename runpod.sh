#!/usr/bin/awk BEGIN{exit system("bash -euo pipefail -c 'f=\"" ARGV[1] "\";n=$(awk \"/^#!\\/bin\\/bash$/ {print NR}\" \"$f\" ); t=$(sed -e \"s/^# //\" -ne \"2,$((n-1))p\" \"$f\"); s=$(tail +$n \"$f\") ;  eval \"echo \\\"$t\\\" \" | bash -eu'")}
# timout=300
# name="adhoc-\$HOSTNAME-\$USER-$(basename $f| sed "s/[^[:alnum:]]/-/g")-\$timout"
# kubectl get job \$name &> /dev/null && kubectl delete job \$name > /dev/null
# kubectl apply -f - <<EOF > /dev/null
# apiVersion: batch/v1
# kind: Job
# metadata:
#   name: \$name
# spec:
#   template:
#     spec:
#       containers:
#       - name: \${name}-cont
#         image: centos
#         command:
#         - sh
#         - "-c"
#         - |
#           /bin/sh <<LOL
# $(echo "$s"| sed 's/^/          /')
#           LOL
#       restartPolicy: Never
# EOF
# if [[ "\$?" != "0" ]]; then
#    exit 1
# fi
# podname=\$(kubectl get pods --sort-by=.metadata.creationTimestamp --selector=job-name=\$name -o jsonpath="{.items[0].metadata.name}")
# sleep 1
# retval=1
# for i in {1..200}; do 
#   status=\$(kubectl get pod \$podname -o jsonpath='{.status.phase}') || break
#   [[ "\$status" == "Failed" ]] && break
#   [[ "\$status" == "Failed" ]] && retval=0 && break
#   sleep 1
# done
#
# kubectl logs -f \$podname
# 
# exit \$retval
#!/bin/bash

echo hello from k8s
sdf