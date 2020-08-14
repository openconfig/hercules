# Patches applied to generated Hercules Modules

This directory contains patches that are automatically applied to the generated
hercules protobuf files for the OpenConfig hercules modules. They reflect
temporary changes that are required before upstream code generation fixes are
updated.

Each patch is enumerated in this file:

 * `imports.patch` -- this patch removes unused imports, it can be removed when
   ygot issue #432 is resolved.
