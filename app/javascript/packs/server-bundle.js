import ReactOnRails from "react-on-rails";

import WatchersBlock from "../bundles/app/ticketShowPage/components/WatchersBlock";
import Calendar from "../bundles/app/Units/components/Calendar";
import Units from "../bundles/app/shared/components/Units";
import QrCode from "qrcode.react";

ReactOnRails.register({
  WatchersBlock,
  Calendar,
  QrCode,
  Units,
});
