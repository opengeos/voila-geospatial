FROM jupyter/base-notebook:latest

RUN mamba install -c conda-forge leafmap geemap mapwidget geopandas localtileserver voila nodejs -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir ./notebooks
COPY /notebooks ./notebooks

COPY run.sh .

ENV PROJ_LIB='/opt/conda/share/proj'

USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension

EXPOSE 8866

CMD ["/bin/bash", "run.sh"]
