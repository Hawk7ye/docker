# Laravel

## Environment Variables

You might wanna adjust some values:

- UPLOAD_MAX_FILESIZE (default: 2M)
- POST_MAX_SIZE (default: 8M)

## Example docker-compose.yml

```yaml
version: "3"

services:
  app:
    image: laravel
    container_name: app
    restart: unless-stopped
    volumes:
      - ./:/var/www/html
    environment:
      - UPLOAD_MAX_FILESIZE=2M
      - POST_MAX_SIZE=8M
```
