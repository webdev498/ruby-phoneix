class LabelA < Label

  # Header and footer
  HEADER = 19
  FOOTER = 23

  # These are the widths and heights for section 1 labels
  SEC1H = 154
  LABEL1W = 216
  LABEL1H = SEC1H
  LABEL2W = 227
  LABEL2H = SEC1H
  LABEL3W = 168
  LABEL3H = SEC1H / 2
  LABEL4W = LABEL3W
  LABEL4H = LABEL3H

  # These are the widths and heights for section 2 labels
  SEC2H = 51
  SEC2EMPTY = 24
  LABEL5W = 112
  LABEL5H = SEC2H - SEC2EMPTY
  LABEL6W = LABEL5W
  LABEL6H = LABEL5H
  LABEL7W = LABEL5W
  LABEL7H = LABEL5H
  LABEL8W = LABEL5W
  LABEL8H = LABEL5H
  LABEL9W = 156
  LABEL9H = LABEL5H

  # These are the widths and heights for section 3 labels
  SEC3H = 575
  LABEL10W = 216
  LABEL10H = SEC3H / 2
  LABEL11W = LABEL10W
  LABEL11H = LABEL10H
  LABEL12W = 388
  LABEL12H = SEC3H

  # Builds the label one section at a time, passing in some constants such as font
  # and font size, line spacing, and padding.
  def build_label
    default_leading SPACING
    pad(HEADER) do
      font(FONT, size: FONT_M) do
        grab_data
        sec1
        sec2
        sec3
      end
    end
  end

  # First section of the label page, containing 4 blocks
  def sec1
    label1
    label2
    label3
    label4
  end

  # First block of the label page
  def label1
    bounding_box([0, HEIGHT - 15], width: LABEL1W, height: LABEL1H) do
      pad_left = PAD * 2
      if(@print_barcode_on_label)
        pad_right = PAD + BAR_H
        rotate(90, origin: [LABEL1W - PAD / 2, PAD * 2]) do
          @barcode.annotate_pdf( self, {x: LABEL1W - PAD / 2, y: PAD * 2, xdim: BAR_W, height: BAR_H})
        end
      else
        pad_right = PAD
      end
      # stroke_bounds
      indent(pad_left, pad_right) do
        add_heading(0, LABEL1H, LABEL1W - pad_left - PAD, 36)
        text "RX <b>#{@rx_number}</b> #{@doctor}", inline_format: true
        float do text "#{@patient}" end
        text "#{@pharmacist}", align: :right
        text_box "#{@directions}", at: [0, cursor + PAD / 4], width: LABEL1W - pad_left - pad_right, height: FONT_M * 5 + PAD / 2, valign: :center
        move_down FONT_M * 5 + PAD / 2
        text_box "#{trim(@dispensed).to_s} <b>#{@drug}</b>", at: [0, cursor], width: LABEL1W - pad_left - pad_right, height: FONT_M, inline_format: true
        float do text "\n#{@manufacturer}", size: FONT_S end
        text "\n#{@generic}", align: :right, size: FONT_S
        if(@refill_thru_date)
          float do text "REFILL UNTIL #{@refill_thru}", inline_format: true, size: FONT_S, character_spacing: CHAR_SPACING end
        elsif(@enter_discard_date)
          float do text "DISCARD AFTER #{@discard_date}", inline_format: true, size: FONT_S, character_spacing: CHAR_SPACING end
        elsif(@enter_expiration_date)
          float do text "EXPIRES #{@expires}", inline_format: true, size: FONT_S, character_spacing: CHAR_SPACING end
        end
        if(@fill_num == 0)
          text "N:#{@last_filled}", align: :right, size: FONT_S, character_spacing: CHAR_SPACING
        else
          text "N:#{@written} R:#{@last_filled}", align: :right, size: FONT_S, character_spacing: CHAR_SPACING
        end
        if(@remaining == 0)
          text "#{@remaining} REFILLS"
        elsif (@remaining == 1)
          text "#{@remaining} REFILL BEFORE #{@expires}"
        else
          text "#{@remaining} REFILLS BEFORE #{@expires}"
        end
      end
    end
  end

  # Second block of the label page
  def label2
    bounding_box([LABEL1W, HEIGHT - 15], width: LABEL2W, height: LABEL2H) do
      # stroke_bounds
      indent(PAD, PAD) do
        font_size FONT_S do
          move_down PAD / 2
          text "RX #{@rx_number} #{@written} #{@pharmacist} Refills #{@refills} Left #{@remaining}"
          bounding_box([0, LABEL2H - (PAD + FONT_S)], width: (LABEL2W - PAD * 2) * 0.6 - PAD, height: LABEL2H - (PAD / 2 + FONT_S) * 4) do
            text "#{@patient_addr}\n#{@doctor_addr}"
            text_box "#{@directions}", at: [0, cursor + PAD / 4], width: (LABEL2W - PAD * 2) * 0.6 - PAD, height: FONT_S * 5 + PAD / 2, valign: :center
          end
          bounding_box([(LABEL2W - PAD * 2) * 0.6, LABEL2H - (PAD + FONT_S)], width: (LABEL2W - PAD * 2) * 0.4, height: LABEL2H - (PAD / 2 + FONT_S) * 4) do
            text "#{@plan_id}\n"
            if( @copay != "" )
              text "#{sprintf("Copay    $%5.2f", @copay)}\n"
            else
              text "#{sprintf("         $%5.2f", @plan_amount)}"
            end
            text "#{@npi}\nDEA #{@dea}\n"
            text_box "AUTH #{@claim}", at: [0, cursor], width: (LABEL2W - PAD * 2) * 0.4, height: FONT_S, overflow: :shrink_to_fit
            move_down FONT_S
            text "Presc     #{trim(@dispensed)}\n" +
              "#{sprintf("Cost     $%5.2f", @cost)}\n#{sprintf("Awp      $%5.2f", @awp)}\n" +
              "#{sprintf("Price    $%5.2f", @price)}\n#{sprintf("Fee      $%5.2f", @fee)}\n", leading: 1
            if( @print_discount_on_label )
              text "#{sprintf("Discount $%5.2f", @discount)}\n"
            else
              text "\n"
            end
            text "Mfg #{@manufacturer}\n"
          end
          move_down PAD / 2
          text_box "#{@drug}", at: [0, cursor], width: (LABEL2W - PAD * 2) * 0.67, height: FONT_S * 2 + PAD / 2
          text "NDC #{@ndc}", align: :right
          text "DAYS SUPPLY #{@days.to_s}  DAW #{@daw.to_s}  CP #{@childproof}  " +
            "SCHED #{@sched}  Qty #{trim(@dispensed)}"
        end
      end
    end
  end

  # Third block of the label page
  def label3
    bounding_box([LABEL1W + LABEL2W, HEIGHT - 15], width: LABEL3W, height: LABEL3H) do
      # stroke_bounds
      indent(PAD, PAD) do
        font_size FONT_S do
          text "#{@patient_addr_gap}\n#{@patient_phone} DOB #{@patient_birth}", valign: :center, align: :center
        end
      end
    end
  end

  # Fourth block of the label page
  def label4
    bounding_box([LABEL1W + LABEL2W, HEIGHT - 15 - LABEL3H], width: LABEL4W, height: LABEL4H) do
      # stroke_bounds
      indent(PAD, PAD) do
        font_size FONT_S do
          move_down PAD * 2
          float do text "#{@rx_number} #{@last_filled} #{@pharmacist}" end
          text "#{sprintf("$%5.2f", @price)}", align: :right
          text_box "#{@patient}/#{@doctor_abbr}", at: [0, cursor], width: LABEL4W - PAD * 2, height: FONT_S, overflow: :shrink_to_fit
          float do text "\n#{@drug}" end
          text "\n#{trim(@dispensed)}", align: :right
          if(@copay != "")
            text "#{@plan} COPAY #{sprintf("$%5.2f", @copay)}\nAUTHORIZATION #{@claim}\n\n X_____________________________"
          else
            text "#{@plan} #{sprintf("$%5.2f", @plan_amount)}\nAUTHORIZATION #{@claim}\n\n X_____________________________"
          end
        end
      end
    end
  end

  # Second section of the label page, containing 5 blocks
  def sec2
    label5
    label6
    label7
    label8
    # label9
  end

  # Fifth block of the label page
  def label5
    bounding_box([0, HEIGHT - HEADER - SEC1H], width: LABEL5W, height: LABEL5H) do
      # stroke_bounds
      indent(PAD, PAD) do
        if(@print_warning_labels)
          text "WARNING LABEL", valign: :center, align: :center
        end
      end
    end
  end

  # Sixth block of the label page
  def label6
    bounding_box([LABEL5W, HEIGHT - HEADER - SEC1H], width: LABEL6W, height: LABEL6H) do
      # stroke_bounds
      indent(PAD, PAD) do
        if(@print_warning_labels)
          text "WARNING LABEL", valign: :center, align: :center
        end
      end
    end
  end

  # Seventh block of the label page
  def label7
    bounding_box([LABEL5W + LABEL6W, HEIGHT - HEADER - SEC1H], width: LABEL7W, height: LABEL7H) do
      # stroke_bounds
      indent(PAD, PAD) do
        if(@print_warning_labels)
          text "WARNING LABEL", valign: :center, align: :center
        end
      end
    end
  end

  # Eighth block of the label page
  def label8
    bounding_box([LABEL5W + LABEL6W + LABEL7W, HEIGHT - HEADER - SEC1H], width: LABEL8W, height: LABEL8H) do
      # stroke_bounds
      indent(PAD, PAD) do
        if(@print_warning_labels)
          text "WARNING LABEL", valign: :center, align: :center
        end
      end
    end
  end

  # Ninth block of the label page
  # Deals with Barccode formatting
  # def label9
  #   bounding_box([LABEL5W + LABEL6W + LABEL7W + LABEL8W, HEIGHT - HEADER - SEC1H], width: LABEL9W, height: LABEL9H) do
  #     stroke_bounds
  #     indent(PAD, PAD) do
  #       @barcode.annotate_pdf(self, {x: PAD, y: PAD, xdim: BAR_W, height: BAR_H})
  #     end
  #   end
  # end

  # Third section of the label page, containing 3 blocks
  def sec3
    label10
    label11
    # label12
  end

  # Tenth block of the label page
  def label10
    bounding_box([0, HEIGHT - HEADER - SEC1H - SEC2H], width: LABEL10W, height: LABEL10H) do
      # stroke_bounds
      indent(PAD, PAD) do
        add_heading(0, LABEL10H, LABEL10W - PAD * 2, 48)
        float do text "RX #{@rx_number}  #{@last_filled}" end
        if(@remaining == 1)
          text "REFILL #{@remaining}", align: :right
        else
          text "REFILLS #{@remaining}", align: :right
        end
        move_down PAD / 4
        text_box "#{@patient_addr}\n#{@patient_phone}", at: [0, cursor + PAD / 4], width: LABEL10W - PAD * 2, height: FONT_M * 5 + PAD / 2
        move_down FONT_M * 5 + PAD / 2
        text_box "#{@doctor_addr}\n#{@doctor_phone}", at: [0, cursor + PAD / 4], width: LABEL10W - PAD * 2, height: FONT_M * 5 + PAD / 2
        move_down FONT_M * 5 + PAD / 2
        if(@facility)
          text "FACILITY #{@facility}"
        else
          text "\n"
        end
        text_box "#{@drug}", at: [0, cursor], width: (LABEL10W - PAD * 2) * 0.8, height: FONT_M
        text "Qty #{trim(@dispensed)}", align: :right
        text "NDC #{@ndc} #{@manufacturer}"
        text_box "#{@message}", at: [0, cursor + PAD / 4], width: LABEL10W - PAD * 2, height: FONT_M * 5 + PAD / 2, valign: :center
        move_down FONT_M * 5 + PAD / 2
        float do text "#{sprintf("#{@plan_id} $%5.2f", @plan_amount)}", character_spacing: CHAR_SPACING end
        if( @print_discount_on_label )
          if(@copay != "")
            move_down FONT_M
            float do text "#{sprintf("DISCOUNT $%5.2f", @discount)}" end
            text "#{sprintf("COPAY $%5.2f", @copay)}", align: :right, character_spacing: CHAR_SPACING
          else
            move_down FONT_M
            text "#{sprintf("DISCOUNT $%5.2f", @discount)}"
          end
        else
          if(@copay != "")
            text "#{sprintf("COPAY $%5.2f", @copay)}", align: :right, character_spacing: CHAR_SPACING
          else
            text "\n"
          end
        end
        text "AUTHORIZATION #{@claim}"
      end
    end
  end

  # Eleventh block of the label page
  def label11
    bounding_box([0, HEIGHT - HEADER - SEC1H - SEC2H - LABEL10H], width: LABEL11W, height: LABEL11H) do
      # stroke_bounds
      indent(PAD, PAD) do
        add_heading(0, LABEL11H, LABEL11W - PAD * 2, 48)
        float do text "RX #{@rx_number}  #{@last_filled}" end
        if(@remaining == 1)
          text "REFILL #{@remaining}", align: :right
        else
          text "REFILLS #{@remaining}", align: :right
        end
        move_down PAD / 2
        text_box "#{@patient_addr}\n#{@patient_phone}", at: [0, cursor], width: LABEL10W - PAD * 2, height: FONT_M * 5 + PAD / 2
        move_down FONT_M * 5 + PAD
        text_box "#{@doctor_addr}\n#{@doctor_phone}", at: [0, cursor], width: LABEL10W - PAD * 2, height: FONT_M * 5 + PAD / 2
        move_down FONT_M * 5 + PAD
        if(@facility)
          text "FACILITY #{@facility}"
        else
          text "\n"
        end
        text_box "#{@drug}", at: [0, cursor], width: (LABEL10W - PAD * 2) * 0.8, height: FONT_M
        text "Qty #{trim(@dispensed)}", align: :right
        text "NDC #{@ndc} #{@manufacturer}"
        # if(@print_barcode_on_receipt)
        #   move_down PAD / 2
        #   @barcode.annotate_pdf(self, {x: PAD * 8, y: cursor - BAR_H, xdim: BAR_W, height: BAR_H})
        #   move_down PAD / 2
        # else
          move_down BAR_H + PAD
        end
        move_down BAR_H + PAD / 2
        float do text "#{sprintf("#{@plan_id} $%5.2f", @plan_amount)}", character_spacing: CHAR_SPACING end
        if( @print_discount_on_label )
          if(@copay != "")
            move_down FONT_M
            float do text "#{sprintf("DISCOUNT $%5.2f", @discount)}" end
            text "#{sprintf("COPAY $%5.2f", @copay)}", align: :right, character_spacing: CHAR_SPACING
          else
            move_down FONT_M
            text "#{sprintf("DISCOUNT $%5.2f", @discount)}"
          end
        else
          if(@copay != "")
            text "#{sprintf("COPAY $%5.2f", @copay)}", align: :right, character_spacing: CHAR_SPACING
          else
            text "\n"
          end
        end
        text "AUTHORIZATION #{@claim}"
        float do text "#{@last_filled} RX#{@rx_number}" end
        if(@copay != "")
          text "#{@plan} #{sprintf("$%5.2f", @copay)}", align: :right, character_spacing: CHAR_SPACING
        else
          text "#{@plan} #{sprintf("$%5.2f", @plan_amount)}", align: :right, character_spacing: CHAR_SPACING
        end
      end
    end
  end

  # Twelfth block of the label page
  # Not clear what portion of the label this is
  #def label12
  #   bounding_box([LABEL10W, HEIGHT - HEADER - SEC1H - SEC2H], width: LABEL12W, height: LABEL12H - FOOTER) do
  #     stroke_bounds
  #     indent(PAD, PAD) do
  #       add_heading(0, LABEL12H - FOOTER, LABEL12W - PAD * 2, 48)
  #       float do text "<b>RX #{@rx_number}</b>", inline_format: true end
  #       text "<b>For: #{@patient}</b>\n\n", align: :right, inline_format: true
  #       text "#{@drug}\n", inline_format: true
  #       text "#{@pronunciation}\n#{@other_names}\n\n#{@uses}\n\n#{@warning}\n\n#{@disclaimer}"
  #     end
  # end
