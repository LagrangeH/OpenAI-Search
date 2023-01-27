#!/usr/bin/env python3
import sys
from argparse import Namespace

from loguru import logger as log

from logger import configure_logging
from models import ArgsNamespace, AI


@log.catch()
def main() -> None:
    config = ArgsNamespace()

    # Inline mode
    if config.prompt:
        AI(config).request()

    # Interactive mode
    else:
        log.debug("Interactive mode enabled.")

        while True:
            config = ArgsNamespace(source=input('# '), interactive_mode=True)
            log.debug(f"Got {config = } for interactive mode")

            if config is None:
                continue

            elif config.prompt in ('exit', 'quit'):
                raise SystemExit
                
            elif not config.prompt and config.api_key:
                AI(config)
                
            elif not config.prompt:
                log.critical("[x] You should write any prompt.")
                
            else:
                AI(config).request()


if __name__ == '__main__':
    configure_logging('-d' in sys.argv or '--debug' in sys.argv)

    try:
        main()
        
    except (KeyboardInterrupt, SystemExit):
        log.error("Process finished.")

    except Exception as err:
        log.opt(exception=True).error(err)
