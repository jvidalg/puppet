FROM centos:7

ARG version="6.0.0"
ARG vcs_ref
ARG build_date

ENV PUPPET_AGENT_VERSION="$version"
ENV PATH=/opt/puppetlabs/server/bin:/opt/puppetlabs/puppet/bin:/opt/puppetlabs/bin:$PATH

#SHELL ["/bin/bash", "-eo", "pipefail", "-c"]

LABEL org.label-schema.maintainer="nobody" \
      org.label-schema.vendor="Puppet" \
      org.label-schema.url="nobody" \
      org.label-schema.name="Puppet Agent (CentOS7)" \
      org.label-schema.license="Apache-2.0" \
      org.label-schema.version=$PUPPET_AGENT_VERSION \
      org.label-schema.vcs-url="https://github.com/jvidalg/puppet" \
      org.label-schema.vcs-ref="vcs_ref" \
      org.label-schema.build-date="build_date" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.dockerfile="/Dockerfile"

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
	systemd-tmpfiles-setup.service ] || rm -f $i; done); \ 
	rm -f /lib/systemd/system/multi-user.target.wants/*;\
	rm -f /etc/systemd/system/*.wants/*;\
	rm -f /lib/systemd/system/local-fs.target.wants/*; \
	rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
	rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
	rm -f /lib/systemd/system/basic.target.wants/*;\
	rm -f /lib/systemd/system/anaconda.target.wants/*;
	VOLUME [ "/sys/fs/cgroup" ]
	CMD ["/usr/sbin/init"]

RUN yum update -y && \
    #yum install applydeltarpm && \
    yum update -y && \
    yum -y install ntpdate && \
    rpm -Uvh https://yum.puppet.com/puppet6-release-el-7.noarch.rpm && \
    #firewall-cmd --permanent --add-port=8140/tcp && \
    #firewall-cmd --reload && \
    yum install -y puppet-agent
    #puppet resource service puppet ensure=running enable=true

ENTRYPOINT ["/opt/puppetlabs/bin/puppet"]
CMD ["agent", "--verbose", "--onetime", "--no-daemonize", "--summarize"]

COPY Dockerfile /
