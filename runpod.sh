#!/usr/bin/env -S bash -euo pipefail -c 'f="$0";n=$(awk "/^#!.+$/ {n=NR}END{print n}" "$f" ); t=$(sed -e "s/^# //" -ne "2,$((n-1))p" "$f"); s=$(tail +$n "$f" | base64) ; i="$(read -t 0 && base64)" eval "echo \\"$t\\"" | bash -eu'
# timeout=300
# mount=/mnt
# name="adhoc-\$HOSTNAME-\$USER-$(basename $f| sed "s/[^[:alnum:]]/-/g")-\$timeout"
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
#         image: alpine
#         command:
#         - sh
#         - "-c"
#         - "test -f \$mount/stdin \&\& cat \$mount/stdin \| \$mount/script $@ \|\| \$mount/script $@"
#         volumeMounts:
#         - mountPath: \$mount
#           name: data
#       restartPolicy: Never
#       volumes:
#         - name: data
#           secret:
#             defaultMode: 0777
#             secretName: \${name}-data
# ---
# apiVersion: v1
# kind: Secret
# metadata:
#   name: \${name}-data
# data:
#   stdin: $i
#   script: $s
# EOF
# [[ "\$?" != "0" ]] && exit 1
# podname=\$(kubectl get pods --sort-by=.metadata.creationTimestamp --selector=job-name=\$name -o jsonpath="{.items[0].metadata.name}")
# retval=1
# for (( i=1; i<=\$timeout; i++ )); do 
#   status=\$(kubectl get pod \$podname -o jsonpath='{.status.phase}') || break
#   [[ "\$status" == "Failed" ]] && break
#   [[ "\$status" == "Succeeded" ]] && retval=0 && break
#   sleep 1
# done
# kubectl logs -f \$podname
# exit \$retval
#
#!/bin/sh
echo $(cat) from $@
