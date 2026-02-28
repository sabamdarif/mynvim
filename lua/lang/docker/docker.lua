return {
    lsp_servers = { "dockerls", "docker_compose_language_service" },

    lsp_config = {
        dockerls = {},
        docker_compose_language_service = {},
    },

    mason_packages = {
        "dockerfile-language-server",
        "docker-compose-language-service",
    },

    treesitter = { "dockerfile" },
}
