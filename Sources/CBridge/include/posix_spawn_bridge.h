#ifndef posix_spawn_bridge_h
#define posix_spawn_bridge_h

#include <sys/types.h>
#include <sys/ioctl.h>
#include <util.h>

pid_t fasty_forkpty(int *amaster, char *name, 
                     const struct termios *termp, 
                     const struct winsize *winp);

int fasty_exec_shell(const char *shell_path);
int fasty_waitpid(pid_t pid, int *status, int options);
int fasty_kill(pid_t pid, int sig);

#endif
