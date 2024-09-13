#include "version.h"

#include "config/config.h"
#include "log/log.h"

#define LOG_SDK_VERSION LOGI << (STRING(LINK_STRING(COMMON_VERSION, SDK_VERSION)))
#define LOG_BUILD_VERSION LOGI << (STRING(LINK_STRING(COMMON_BUILD_VERSION, SDK_BUILD_VERSION)))
#define LOG_BUILD_TIME LOGI << (STRING(SHOW_LITERAL(VERSION build in, BUILD_TIME)))
#define LOG_BRANCH LOGI << (STRING(SHOW_LITERAL(VERSION branch:, GIT_BRANCH)))
#define LOG_COMMIT LOGI << (STRING(SHOW_LITERAL(VERSION commit id:, GIT_HASH)))

namespace youya {

const std::string version() {
    LOG_SDK_VERSION;
    LOG_BUILD_VERSION;
    LOG_BUILD_TIME;
    LOG_BRANCH;
    LOG_COMMIT;
    return (std::string(SDK_VERSION_STR));
}

}  // namespace youya