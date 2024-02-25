# General Variables for Docker Compose Configurations

This folder contains a `general-vars.yaml` file that provides general basic variables used across multiple Docker Compose configurations. `global.yaml` is a work in progress, and needs to be honed in more before ready for adoption.

## Usage

The `general-vars.yaml` file contains variables that can be shared among multiple `docker-compose.yaml` files to maintain consistency and ease of management.

### Variables

Below are the variables defined in the `general-vars.yaml` file along with their descriptions:

- **tz**: Specifies the timezone to be used in the containers.
- **config**: Specifies the directory path for storing configuration files.
- **data**: Specifies the directory path for storing data files.

### Updating Variables

To update the variables, edit the `general-vars.yaml` file and modify the values according to your requirements.

## Integration with Docker Compose

To use these variables in your Docker Compose configurations, follow these steps:

1. In each `docker-compose.yaml` file where you want to use these variables, include the `general-vars.yaml` file as an external volume:

    ```yaml
    volumes:
      - ../vars/general-vars.yaml:/general-vars.yaml
    ```

2. Reference the variables in your `docker-compose.yaml` files using `${var_name}` syntax. For example:

    ```yaml
    environment:
      - TZ=${tz}
    ```

## Example

Below is an example of how you can integrate the `general-vars.yaml` file into your Docker Compose configuration:

```yaml
version: '3'

services:
  my_service:
    image: my_image
    environment:
      - TZ=${tz}
    volumes:
      - ../vars/general-vars.yaml:/general-vars.yaml
      - ./data:${data}
      - ./config:${config}
    ...
```

## Note

- Ensure that the paths to the general-vars.yaml file are correctly specified based on your directory structure.
- Verify that the variables are correctly referenced in your Docker Compose configurations to avoid any errors during deployment.

Feel free to customize this template according to your specific needs and preferences.
