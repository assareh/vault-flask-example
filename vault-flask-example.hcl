path "secret/data/foo" {
    capabilities = ["read"]
}

path "secret/data/bar" {
    capabilities = ["read"]
}

path "auth/token/lookup-self*" {
    capabilities = ["read"]
}

path "sys/internal/ui/mounts/auth/token/lookup-self" {
    capabilities = ["read"]
}
