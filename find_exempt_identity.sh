#!/bin/bash
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#set -x

function check_variables () {
    if [  -z "$org_id" ]; then
        printf "ERROR: GCP organization id variable is not set.\n\n"
        printf "To set export org_id=123456789\n\n"
        exit
    fi 
}

function find_organization_log_exemptions () {
    echo "Searching Organization policy: $org_id"
    gcloud organizations get-iam-policy $org_id  --format=json | jq --raw-output ".auditConfigs[].auditLogConfigs[].exemptedMembers[]" 2> /dev/null
}

function find_folder_log_exemptions () {
    for folder in $(gcloud asset search-all-resources --asset-types=cloudresourcemanager.googleapis.com/Folder --scope=organizations/$org_id --format='json(name.basename())' |jq -r '.[].name'); do
        echo "Searching Folder policy: $folder"
        gcloud resource-manager folders get-iam-policy $folder --format=json | jq --raw-output ".auditConfigs[].auditLogConfigs[].exemptedMembers[]" 2> /dev/null
    done
}

function find_project_log_exemptions () {
    for project in $(gcloud asset search-all-resources --asset-types=cloudresourcemanager.googleapis.com/Project --scope=organizations/$org_id --format='json(name.basename())' |jq -r '.[].name'); do
        echo "Searching project policy: $project"
        gcloud projects get-iam-policy $project --format=json | jq --raw-output ".auditConfigs[].auditLogConfigs[].exemptedMembers[]" 2> /dev/null
    done
}


check_variables
find_organization_log_exemptions 
find_folder_log_exemptions
find_project_log_exemptions