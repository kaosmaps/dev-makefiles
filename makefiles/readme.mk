# Framework version: 0.0.1
# Module version: 0.0.1

# Include configuration
include makefiles/config.mk

# README generation tasks
.PHONY: .generate-readme

define README_CONTENT
# $(SAUBER_PACKAGE_NAME)

## Description

$(SAUBER_PACKAGE_NAME) is a Python package that [brief description of what your package does].

## Installation

You can install $(SAUBER_PACKAGE_NAME) using pip:

```bash
pip install $(SAUBER_PACKAGE_NAME)
```

## Usage

Here's a quick example of how to use $(SAUBER_PACKAGE_NAME):

```python
from $(subst -,_,$(SAUBER_PACKAGE_NAME)) import some_function

result = some_function()
print(result)
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
endef
export README_CONTENT

.generate-readme:
	@echo "Generating README.md..."
	@echo "$$README_CONTENT" > $(TARGET_DIR)/README.md
	@echo "README.md generated successfully."
