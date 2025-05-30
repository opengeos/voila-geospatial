FROM condaforge/mambaforge:latest

# The HF Space container runs with user ID 1000.
RUN useradd -m -u 1000 user
USER user

# Set home to the user's home directory
ENV HOME=/home/user \
  PATH=/home/user/.local/bin:$PATH

# Set the working directory to the user's home directory
WORKDIR $HOME/app
COPY --chown=user . .

RUN mamba env create --prefix $HOME/env  -f ./environment.yml

EXPOSE 7860
WORKDIR $HOME/app

CMD ["mamba", "run", "-p", "/home/user/env", "--no-capture-output", "voila", "--no-browser", "notebooks/"]