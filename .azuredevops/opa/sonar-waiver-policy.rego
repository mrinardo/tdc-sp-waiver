package waiver

import rego.v1

default allow := false

allow if { 
    waiver_is_set
    not waiver_is_expired
}

waiver_is_set if {
    waiver_projects := data.waiver_projects
    waiver_projects[input.project]
} 

waiver_is_expired if {
    project_expiration := data.waiver_projects[input.project].due_date
    now := time.now_ns()
    expiration_ns := time.parse_rfc3339_ns(project_expiration)
    now > expiration_ns
}