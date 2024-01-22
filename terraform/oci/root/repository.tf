resource "oci_devops_repository" "test_repository" {
    #Required
    name = "root"
    project_id = oci_devops_project.root.id
    repository_type = "HOSTED"
}