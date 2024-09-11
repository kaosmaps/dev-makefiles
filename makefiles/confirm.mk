# Framework version: 1.0.0
# Module version: 1.0.0

# Generic confirmation module

# Function to confirm actions
# Usage: $(call confirm,prompt,default)
define confirm
$(shell . makefiles/scripts/user_interaction.sh; confirm "$(1)" "$(2)")
endef

# Function to get user input
# Usage: $(call user_input,prompt,default)
define user_input
$(shell . makefiles/scripts/user_interaction.sh; user_input "$(1)" "$(2)")
endef
