self: super: {
  btop = super.btop.override { cudaSupport = true; };
}
