#define _POSIX_C_SOURCE 200112L

#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <util.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>

pid_t fasty_forkpty(int *amaster, char *name, 
                     const struct termios *termp, 
                     const struct winsize *winp) {
    return forkpty(amaster, name, termp, winp);
}

int fasty_exec_shell(const char *shell_path) {
    // Set environment
    setenv("TERM", "xterm-256color", 1);
    
    // Execute shell
    execl(shell_path, shell_path, NULL);
    
    // If exec fails
    return -1;
}

int fasty_waitpid(pid_t pid, int *status, int options) {
    return waitpid(pid, status, options);
}

int fasty_kill(pid_t pid, int sig) {
    return kill(pid, sig);
}
