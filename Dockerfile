FROM quay.io/cuppett/ubi8-php:74

ENV PHP_MEMORY_LIMIT="512M" \
    OPCACHE_REVALIDATE_FREQ="1" \
    WORDPRESS_VERSION="5.7" \
    WORDPRESS_SHA1="76d1332cfcbc5f8b17151b357999d1f758faf897"

USER root

# Copying in source code

COPY . /tmp/src

# Change file ownership to the assemble user.

RUN set -ex; \
    chown -R 1001:0 /tmp/src; \
    mkdir -p /tmp/scripts; \
    mv /tmp/src/.s2i/bin/* /tmp/scripts

# Run assemble as non-root user

USER 1001

# Assemble script sourced from builder image based on user input or image metadata.

RUN /tmp/scripts/assemble

# Run script sourced from builder image based on user input or image metadata.

CMD /tmp/scripts/run