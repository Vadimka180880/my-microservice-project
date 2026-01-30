#!/usr/bin/env bash
set -e

echo "==> Installing dev tools (Ubuntu/Debian)"

# 1) Python 3
if ! command -v python3 >/dev/null; then
  sudo apt update
  sudo apt install -y python3 python3-pip python3-venv
else
  echo "Python exists: $(python3 --version)"
fi

# 2) Docker
if ! command -v docker >/dev/null; then
  echo "==> Installing Docker..."
  sudo apt update
  sudo apt install -y ca-certificates curl gnupg

  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg

  . /etc/os-release
  ARCH="$(dpkg --print-architecture)"
  CODENAME="${VERSION_CODENAME}"

  echo "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu ${CODENAME} stable" \
    | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  echo "Docker installed: $(docker --version)"
else
  echo "Docker exists: $(docker --version 2>/dev/null || true)"
fi

# 3) Docker Compose (plugin)
if docker compose version >/dev/null 2>&1; then
  echo "Docker Compose exists: $(docker compose version | head -n 1)"
else
  echo "==> Installing Docker Compose plugin..."
  sudo apt update
  sudo apt install -y docker-compose-plugin
fi

# 4) Django
VENV_DIR="$HOME/django-venv"

if [ ! -d "$VENV_DIR" ]; then
  echo "==> Creating venv: $VENV_DIR"
  python3 -m venv "$VENV_DIR"
fi

if "$VENV_DIR/bin/python" -m django --version >/dev/null 2>&1; then
  echo "Django exists in venv: $("$VENV_DIR/bin/python" -m django --version)"
else
  echo "==> Installing Django into venv via pip..."
  "$VENV_DIR/bin/pip" install --upgrade pip
  "$VENV_DIR/bin/pip" install django
  echo "Django installed: $("$VENV_DIR/bin/python" -m django --version)"
fi

echo "==> Done"
echo "To use venv later:"
echo "source $VENV_DIR/bin/activate"
