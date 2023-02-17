Available states
----------------

The following states are found in this formula:

.. contents::
   :local:


``monica``
^^^^^^^^^^
*Meta-state*.

This installs the monica, db containers,
manages their configuration and starts their services.


``monica.package``
^^^^^^^^^^^^^^^^^^
Installs the monica, db containers only.
This includes creating systemd service units.


``monica.config``
^^^^^^^^^^^^^^^^^
Manages the configuration of the monica, db containers.
Has a dependency on `monica.package`_.


``monica.service``
^^^^^^^^^^^^^^^^^^
Starts the monica, db container services
and enables them at boot time.
Has a dependency on `monica.config`_.


``monica.clean``
^^^^^^^^^^^^^^^^
*Meta-state*.

Undoes everything performed in the ``monica`` meta-state
in reverse order, i.e. stops the monica, db services,
removes their configuration and then removes their containers.


``monica.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^
Removes the monica, db containers
and the corresponding user account and service units.
Has a depency on `monica.config.clean`_.
If ``remove_all_data_for_sure`` was set, also removes all data.


``monica.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^
Removes the configuration of the monica, db containers
and has a dependency on `monica.service.clean`_.

This does not lead to the containers/services being rebuilt
and thus differs from the usual behavior.


``monica.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^
Stops the monica, db container services
and disables them at boot time.


