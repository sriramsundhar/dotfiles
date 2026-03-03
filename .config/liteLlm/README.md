# Claude code using litellm and copilot

## LiteLLM Configuration

This directory contains configuration for running LiteLLM as a proxy server for GitHub Copilot models.

## Running LiteLLM

Start the LiteLLM proxy server using the config file:
```bash
docker compose up -d
```
The server will start on `http://0.0.0.0:4000` by default.

## Claude
Run Claude
```sh
claude
```

## Notes
- Check environment variables in [compose.yml](./compose.yml), [zshrc](../../.zshrc) and claude [settings](../../.claude/settings.json).
- Find all available models [here](https://models.litellm.ai/)

This will use claude settings from the [settings.yml](../.claude/settings.yml) file.
Make sure to enable the settings using `stow`.

[ref](https://blog.f12.no/wp/2025/09/22/using-claude-code-with-github-copilot-a-guide/)
