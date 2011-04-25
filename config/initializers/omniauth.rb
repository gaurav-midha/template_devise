Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'KEyXWGPFbn4M0RrCNaRw', 'FwI9CCLiNY9n9yI7XK5N7L9QdlfyjyLp2wclSwrd1Y'
  provider :facebook, '212343812126736', '68336c58f4fdb05ad2540d8f77c2fd35'
end
