@react.component
let make = (~className="") =>
  <svg
    className
    height="1em"
    width="1em"
    strokeMiterlimit="10"
    style={ReactDOM.Style.make(
      ~fillRule="nonzero",
      ~clipRule="evenodd",
      ~strokeLinecap="round",
      ~strokeLinejoin="round",
      (),
    )}
    version="1.1"
    viewBox="0 0 1024 1024"
    xmlns="http://www.w3.org/2000/svg">
    <defs />
    <g opacity="1">
      <path
        d="M511.656 128.844C508.979 129.037 506.963 131.386 507.156 134.062C509.388 175.792 511.282 217.54 513.281 259.281C483.773 248.451 453.797 238.863 423.562 230.281C390.675 220.946 357.507 212.601 324.156 205.094C301.757 200.052 279.276 195.27 256.656 191.312C255.174 191.024 253.726 191.987 253.438 193.469C253.149 194.951 254.112 196.368 255.594 196.656C280.121 201.983 304.472 208.293 328.688 214.875C370.02 226.109 410.962 238.758 451.25 253.312C472.472 260.979 493.529 269.179 514.219 278.188C515.331 301.574 516.547 324.957 517.656 348.344C519.246 381.841 520.688 415.328 522.531 448.812C523.233 461.562 523.907 474.317 524.688 487.062C525.504 500.395 526.621 513.73 527.438 527.062C527.971 535.78 528.429 544.498 528.906 553.219C522.337 557.297 515.858 561.534 509.5 565.938C503.481 570.107 497.474 574.235 491.656 578.688C488.629 581.004 485.623 583.382 482.688 585.812C480.815 587.363 479.004 588.99 477.125 590.531C471.298 595.312 465.543 600.13 460.062 605.312C455.887 609.261 451.954 613.427 447.969 617.562C446.108 619.493 444.208 621.355 442.375 623.312C437.461 628.561 432.8 634.058 428.406 639.75C425.959 642.92 423.512 646.12 421.312 649.469C417.08 655.915 413.269 662.657 409.781 669.531C407.262 674.497 404.821 679.578 402.75 684.75C401.328 688.3 400.209 691.969 399.094 695.625C396.966 702.602 395.17 709.702 393.688 716.844C392.988 720.21 392.314 723.592 391.844 727C390.969 733.341 390.427 739.735 390.062 746.125C389.631 753.697 389.423 761.342 390.5 768.875C391.374 774.989 392.891 781.043 394.812 786.906C397.389 794.768 400.748 802.557 404.906 809.719C407.98 815.012 411.59 820.047 415.344 824.875C424.759 836.984 435.716 847.737 447.656 857.344C452.364 861.131 457.274 864.676 462.188 868.188C468.328 872.575 474.452 876.904 480.875 880.875C486.974 884.645 493.259 888.064 499.531 891.531C510.533 897.612 521.947 902.712 533.844 906.781C535.039 907.19 536.076 907.531 537.281 907.906C538.335 908.235 539.53 908.578 540.594 908.875C542.587 909.431 545.543 910.581 546.719 908.031C547.034 907.348 547.135 906.23 547.25 905.562C547.486 904.186 547.691 902.822 547.875 901.438C548.467 896.995 548.866 892.532 549.188 888.062C550.241 873.401 550.657 858.663 550.875 843.969C551.284 816.473 551.303 788.998 551.406 761.5C551.487 739.997 551.568 718.503 551.469 697C551.326 666.122 550.731 635.236 549.688 604.375C549.066 585.984 548.106 567.597 547.219 549.219C553.852 545.811 560.586 542.588 567.312 539.375C571.915 537.176 576.464 534.862 581.062 532.656C585.913 530.33 590.784 528.037 595.594 525.625C603.16 521.831 610.587 517.796 617.969 513.656C639.521 501.571 660.195 487.365 676.5 468.594C685.376 458.375 692.39 446.266 696.406 433.312C697.745 428.995 698.83 424.558 699.344 420.062C699.909 415.121 699.977 410.115 699.594 405.156C699.005 397.538 697.299 390.039 694.656 382.875C689.386 368.59 680.058 356.074 669.594 345.156C661.095 336.289 651.386 328.603 641.344 321.562C625.494 310.451 608.603 301.023 591.344 292.312C570.878 281.984 549.677 273.16 528.281 264.938C524.617 221.064 520.827 177.188 516.844 133.344C516.65 130.667 514.333 128.65 511.656 128.844ZM529.938 285.281C532.133 286.293 534.346 287.249 536.531 288.281C557.365 298.121 577.862 308.925 597.188 321.5C603.027 325.3 608.772 329.234 614.375 333.375C619.143 336.899 623.805 340.586 628.312 344.438C634.062 349.35 639.491 354.542 644.656 360.062C649.483 365.221 654.089 370.56 658.031 376.438C660.549 380.191 662.724 384.106 664.656 388.188C667.581 394.368 669.774 400.784 670.438 407.625C670.913 412.526 670.597 417.525 669.781 422.375C668.828 428.039 666.97 433.529 664.531 438.719C662.861 442.272 660.879 445.616 658.844 448.969C655.529 454.429 651.855 459.615 647.812 464.562C643.667 469.636 639.169 474.409 634.594 479.094C621.757 492.238 607.434 503.797 592.438 514.375C587.299 518 582.124 521.6 576.812 524.969C570.451 529.004 563.808 532.587 557.281 536.344C553.805 538.345 550.353 540.418 546.906 542.469C546.642 536.992 546.442 531.509 546.188 526.031C545.566 512.671 545.223 499.294 544.531 485.938C542.021 437.507 538.287 389.157 534.5 340.812C533.05 322.295 531.459 303.793 529.938 285.281ZM529.25 559.406C529.366 561.479 529.474 563.552 529.594 565.625C530.732 585.344 531.977 605.039 533.25 624.75C533.725 632.097 534.125 639.47 534.656 646.812C536.732 675.518 538.823 704.22 540.719 732.938C543.157 769.883 545.151 806.9 545.188 843.938C545.202 858.52 545.098 873.132 544.125 887.688C543.833 892.057 543.494 896.437 542.938 900.781C542.792 901.917 542.618 903.057 542.438 904.188C541.223 903.864 540.018 903.576 538.75 903.188C534.072 901.755 529.528 899.931 525.062 897.938C514.606 893.268 504.369 887.751 495 881.156C488.839 876.82 482.879 872.206 477.125 867.344C474.334 864.986 471.513 862.592 468.875 860.062C463.265 854.682 458.068 848.805 453.125 842.812C444.562 832.43 436.801 821.227 430.75 809.188C429.065 805.834 427.584 802.423 426.125 798.969C423.487 792.726 421.11 786.459 419.562 779.844C418.179 773.932 417.473 767.871 417.156 761.812C416.914 757.175 417.184 752.562 417.531 747.938C417.96 742.219 418.629 736.52 419.438 730.844C420.123 726.031 420.73 721.224 421.594 716.438C422.929 709.035 424.735 701.765 426.781 694.531C427.542 691.842 428.186 689.13 428.938 686.438C429.823 683.266 430.772 680.093 431.812 676.969C434.016 670.355 436.683 663.973 439.406 657.562C443.07 648.938 447.182 640.534 451.906 632.438C453.444 629.802 455.019 627.16 456.719 624.625C459.498 620.479 462.645 616.535 465.781 612.656C470.672 606.606 475.787 600.671 481.312 595.188C484.985 591.542 488.999 588.159 492.969 584.844C499.187 579.65 505.588 574.572 512.281 570C517.785 566.241 523.515 562.81 529.25 559.406Z"
        fill="currentColor"
        stroke="none"
      />
    </g>
  </svg>