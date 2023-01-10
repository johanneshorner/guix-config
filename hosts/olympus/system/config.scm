(use-modules (gnu)
             (guix)
             (gnu services ssh)
             (gnu services docker)
             (nongnu packages linux)
             (nongnu system linux-initrd)
             (gnu packages version-control)
             (gnu packages vim))
(use-service-modules desktop dbus networking docker)
(use-package-modules certs shells)

(define my-services 
  (cons*
    (service openssh-service-type)
    (service docker-service-type)
    (elogind-service)
    (service dhcp-client-service-type)
    (dbus-service)
    (modify-services %base-services
             (guix-service-type config => (guix-configuration
               (inherit config)
               (substitute-urls
                (append (list "https://substitutes.nonguix.org")
                  %default-substitute-urls))
               (authorized-keys
                (append (list (local-file "../../../authorized_keys/nonguix.pub"))
                  %default-authorized-guix-keys)))))))

(define root-device (uuid "7e9936b8-7d37-4bc9-974b-f2bd290f7eff"))
(define efi-device (uuid "492A-719E" 'fat))

(define my-file-systems
  (cons* 
    (file-system
      (device root-device)
      (mount-point "/")
      (type "btrfs")
      (options "compress=zstd,subvol=root"))
    (file-system
      (device root-device)
      (mount-point "/home")
      (type "btrfs")
      (options "compress=zstd,subvol=home"))
    (file-system
      (device root-device)
      (mount-point "/gnu")
      (type "btrfs")
      (options "compress=zstd,subvol=gnu"))
    (file-system
      (device root-device)
      (mount-point "/var/log")
      (type "btrfs")
      (options "compress=zstd,subvol=log"))
    (file-system
      (device root-device)
      (mount-point "/swap")
      (type "btrfs")
      (options "subvol=swap"))
    (file-system
     (device efi-device)
     (mount-point "/boot/efi")
     (type "vfat"))
    %base-file-systems))

(operating-system
  (host-name "olympus")
  (locale "en_US.utf8")
  (timezone "Europe/Vienna")

  (kernel linux)
  (firmware (list linux-firmware))
  (initrd microcode-initrd)

  (keyboard-layout (keyboard-layout "de" "neoqwertz"))

  (bootloader (bootloader-configuration
               (bootloader grub-efi-bootloader)
               (targets (list "/boot/efi"))
               (keyboard-layout keyboard-layout)))

  (file-systems my-file-systems)

  (swap-devices
    (list
     (swap-space
       (target "/swap/swapfile")
       (dependencies (filter (file-system-mount-point-predicate "/swap")
                             file-systems)))))

  (users (cons (user-account
                (name "johannes")
                (comment "Johannes Horner")
                (group "users")
                (home-directory "/home/johannes")
                (supplementary-groups '("wheel")))
               %base-user-accounts))

  (services my-services)

  (packages (append (list
                     git
                     neovim
                     nss-certs)     ;; for HTTPS access
             %base-packages)))
