# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

.PHONY: .create-docs

.create-docs:
	@echo "Creating documentation structure..."
	@mkdir -p $(TARGET_DIR)/docs
	@mkdir -p $(TARGET_DIR)/docs/source
	@touch $(TARGET_DIR)/docs/source/conf.py
	@touch $(TARGET_DIR)/docs/source/index.rst
	@echo "Creating Sphinx configuration..."
	@echo "# Configuration file for the Sphinx documentation builder." > $(TARGET_DIR)/docs/source/conf.py
	@echo "project = '$(SAUBER_PACKAGE_NAME)'" >> $(TARGET_DIR)/docs/source/conf.py
	@echo "extensions = ['sphinx.ext.autodoc', 'sphinx.ext.napoleon', 'sphinx_autodoc_typehints', 'myst_parser']" >> $(TARGET_DIR)/docs/source/conf.py
	@echo "Creating index.rst..."
	@echo "Welcome to $(SAUBER_PACKAGE_NAME)'s documentation!" > $(TARGET_DIR)/docs/source/index.rst
	@echo "=======================================" >> $(TARGET_DIR)/docs/source/index.rst
	@echo "" >> $(TARGET_DIR)/docs/source/index.rst
	@echo ".. toctree::" >> $(TARGET_DIR)/docs/source/index.rst
	@echo "   :maxdepth: 2" >> $(TARGET_DIR)/docs/source/index.rst
	@echo "   :caption: Contents:" >> $(TARGET_DIR)/docs/source/index.rst
	@echo "" >> $(TARGET_DIR)/docs/source/index.rst
	@echo "Creating Makefile for Sphinx..."
	@echo "# Minimal makefile for Sphinx documentation" > $(TARGET_DIR)/docs/Makefile
	@echo "SPHINXOPTS    =" >> $(TARGET_DIR)/docs/Makefile
	@echo "SPHINXBUILD   = sphinx-build" >> $(TARGET_DIR)/docs/Makefile
	@echo "SOURCEDIR     = source" >> $(TARGET_DIR)/docs/Makefile
	@echo "BUILDDIR      = build" >> $(TARGET_DIR)/docs/Makefile
	@echo "" >> $(TARGET_DIR)/docs/Makefile
	@echo ".PHONY: help Makefile" >> $(TARGET_DIR)/docs/Makefile
	@echo "" >> $(TARGET_DIR)/docs/Makefile
	@echo "%: Makefile" >> $(TARGET_DIR)/docs/Makefile
	@echo "	@\$(SPHINXBUILD) -M \$@ \"\$(SOURCEDIR)\" \"\$(BUILDDIR)\" \$(SPHINXOPTS) \$(O)" >> $(TARGET_DIR)/docs/Makefile
	@echo "Documentation structure created successfully."
