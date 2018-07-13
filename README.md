# Hercules - vendor-independent interfaces for SDN switch platforms


The Hercules project defines a common set of vendor-independent management
and control interfaces for SDN switches.

This repository contains YANG modules that extend the base
[OpenConfig](https://github.com/openconfig/public) model to define the
management data model for Hercules SDN switches, including both
configuration and telemetry.

Management systems interact with a Hercules switch using a set of
[Protobufs](https://developers.google.com/protocol-buffers/)
which are machine generated from the YANG modules, and stored in the
`proto` directory of this repository. The source YANG modules are stored
in the `yang` directory.

A Hercules switch exposes the data models via [gNMI](https://github.com/openconfig/gnmi/),
which allows manipulation of the configuration of the switch, and retrieval
of its state via polling and streaming RPCs. More details of gNMI can
be found in its [specification](https://github.com/openconfig/reference/blob/master/rpc/gnmi/gnmi-specification.md).

*Note that Hercules data models are in early development and are likely
to change frequently. In particular, backward compatibilty is __not__
guaranteed.  See also [Semantic Versioning for OpenConfig Models](http://www.openconfig.net/docs/semver/).*

## Notices

These files are not part of any official Google product.
