import ReactOnRails from "react-on-rails";

import Calendar from "../bundles/Units/components/Calendar";
import WatchersBlock from "../bundles/app/ticketShowPage/components/WatchersBlock";
import QrCode from "qrcode.react";

ReactOnRails.register({
  WatchersBlock,
  Calendar,
  QrCode,
});
